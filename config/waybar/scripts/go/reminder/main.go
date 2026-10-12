package main

import (
	"fmt"
	"os"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("usage: reminder <daemon|add|list>")
		return
	}

	switch os.Args[1] {
	case "daemon":
		runDaemon()

	case "add":
		addReminder()

	case "list":
		listReminders()

	default:
		fmt.Println("unknown command:", os.Args[1])
	}
}
