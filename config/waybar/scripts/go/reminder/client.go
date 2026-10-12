package main

import (
	"encoding/json"
	"fmt"
	"net"
	"time"
)

type Request struct {
	Action  string    `json:"action"`
	At      time.Time `json:"at,omitempty"`
	Message string    `json:"message,omitempty"`
}

func sendRequest(req Request) error {
	conn, err := net.Dial("unix", socketPath)
	if err != nil {
		return err
	}

	defer conn.Close()

	return json.NewEncoder(conn).Encode(req)
}

func getReminders() ([]Reminder, error) {
	conn, err := net.Dial("unix", socketPath)
	if err != nil {
		return nil, err
	}

	defer conn.Close()

	req := Request{
		Action: "list",
	}

	if err := json.NewEncoder(conn).Encode(req); err != nil {
		return nil, err
	}

	var reminders []Reminder

	if err := json.NewDecoder(conn).Decode(&reminders); err != nil {
		return nil, err
	}

	return reminders, nil
}

func listReminders() {
	reminders, err := getReminders()
	if err != nil {
		fmt.Println("daemon is not running:", err)
		return
	}

	for _, reminder := range reminders {
		fmt.Printf(
			"%d: %s — %s\n",
			reminder.ID,
			reminder.At.Format("15:04"),
			reminder.Message,
		)
	}
}
