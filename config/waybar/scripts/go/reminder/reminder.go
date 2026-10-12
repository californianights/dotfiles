package main

import (
	"os/exec"
	"time"
)

type Reminder struct {
	ID      int       `json:"id"`
	At      time.Time `json:"at"`
	Message string    `json:"message"`
}

func notify(message string) {
	cmd := exec.Command(
		"notify-send",
		"Reminder",
		message,
	)

	_ = cmd.Run()
}

func createReminder(timeStr, message string) (Reminder, error) {
	t, err := time.Parse("15:04", timeStr)
	if err != nil {
		return Reminder{}, err
	}

	now := time.Now()

	target := time.Date(
		now.Year(),
		now.Month(),
		now.Day(),
		t.Hour(),
		t.Minute(),
		0,
		0,
		now.Location(),
	)

	// Если время уже прошло — ставим на завтра.
	if !target.After(now) {
		target = target.Add(24 * time.Hour)
	}

	return Reminder{
		At:      target,
		Message: message,
	}, nil
}
