package main

import (
	"encoding/json"
	"fmt"
	"net"
	"os"
	"time"
)

const socketPath = "/tmp/reminder.sock"

type Daemon struct {
	reminders []Reminder
	nextID    int
}

func runDaemon() {
	// Удаляем старый socket, если он остался после прошлого запуска.
	_ = os.Remove(socketPath)

	listener, err := net.Listen("unix", socketPath)
	if err != nil {
		panic(err)
	}

	defer listener.Close()
	defer os.Remove(socketPath)

	fmt.Println("reminder daemon started")

	d := &Daemon{
		nextID: 1,
	}

	go d.watch()

	for {
		conn, err := listener.Accept()
		if err != nil {
			continue
		}

		go d.handle(conn)
	}
}

func (d *Daemon) handle(conn net.Conn) {
	defer conn.Close()

	var req Request

	if err := json.NewDecoder(conn).Decode(&req); err != nil {
		return
	}

	switch req.Action {
	case "add":
		d.add(req)

	case "list":
		_ = json.NewEncoder(conn).Encode(d.reminders)
	}
}

func (d *Daemon) add(req Request) {
	d.reminders = append(d.reminders, Reminder{
		ID:      d.nextID,
		At:      req.At,
		Message: req.Message,
	})

	d.nextID++

	fmt.Printf(
		"added reminder: %s — %s\n",
		req.At.Format("15:04"),
		req.Message,
	)
}

func (d *Daemon) watch() {
	ticker := time.NewTicker(time.Second)
	defer ticker.Stop()

	for range ticker.C {
		now := time.Now()

		for i := 0; i < len(d.reminders); {
			reminder := d.reminders[i]

			if now.Before(reminder.At) {
				i++
				continue
			}

			notify(reminder.Message)

			d.reminders = append(
				d.reminders[:i],
				d.reminders[i+1:]...,
			)
		}
	}
}
