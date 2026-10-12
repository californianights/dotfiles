package main

import (
	"os"
	"os/exec"
	"strings"
)

func rofiInput(prompt string) (string, error) {
	theme := os.Getenv("HOME") +
		"/.config/waybar/scripts/input.rasi"

	cmd := exec.Command(
		"rofi",
		"-dmenu",
		"-p",
		prompt,
		"-theme",
		theme,
	)

	out, err := cmd.Output()
	if err != nil {
		return "", err
	}

	return strings.TrimSpace(string(out)), nil
}

func addReminder() {
	timeStr, err := rofiInput("Time")
	if err != nil {
		return
	}

	message, err := rofiInput("Message")
	if err != nil {
		return
	}

	reminder, err := createReminder(timeStr, message)
	if err != nil {
		// TODO: показать ошибку через notify-send
		return
	}

	err = sendRequest(Request{
		Action:  "add",
		At:      reminder.At,
		Message: reminder.Message,
	})
	if err != nil {
		// TODO: daemon не запущен
		return
	}
}
