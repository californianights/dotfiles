package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"strings"
	"time"
)

const (
	iconConnected    = "●"
	iconDisconnected = "○"

	toggleOff = "󰂲  Turn Bluetooth off"
	toggleOn  = "󰂯  Turn Bluetooth on"
)

type Device struct {
	MAC       string
	Name      string
	Connected bool
}

func run(name string, args ...string) (string, error) {
	cmd := exec.Command(name, args...)

	out, err := cmd.Output()
	if err != nil {
		return "", err
	}

	return string(out), nil
}

func bluetoothPowered() bool {
	out, err := run("bluetoothctl", "show")
	if err != nil {
		return false
	}

	for _, line := range strings.Split(out, "\n") {
		line = strings.TrimSpace(line)

		if strings.HasPrefix(line, "Powered:") {
			return strings.TrimSpace(strings.TrimPrefix(line, "Powered:")) == "yes"
		}
	}

	return false
}

func getDevices() []Device {
	out, err := run("bluetoothctl", "devices")
	if err != nil {
		return nil
	}

	var devices []Device

	scanner := bufio.NewScanner(strings.NewReader(out))

	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())

		// Expected:
		// Device XX:XX:XX:XX:XX:XX Device Name
		fields := strings.Fields(line)

		if len(fields) < 3 || fields[0] != "Device" {
			continue
		}

		mac := fields[1]
		name := strings.Join(fields[2:], " ")

		info, err := run("bluetoothctl", "info", mac)
		if err != nil {
			continue
		}

		// bluetoothctl may return devices without a usable Name.
		if !strings.Contains(info, "Name:") {
			continue
		}

		connected := strings.Contains(info, "Connected: yes")

		devices = append(devices, Device{
			MAC:       mac,
			Name:      name,
			Connected: connected,
		})
	}

	return devices
}

func startScan() func() {
	cmd := exec.Command("bluetoothctl", "--timeout", "3", "scan", "on")

	// We don't care about scan output.
	cmd.Stdout = nil
	cmd.Stderr = nil

	if err := cmd.Start(); err != nil {
		return func() {}
	}

	return func() {
		if cmd.Process != nil {
			_ = cmd.Process.Kill()
		}
	}
}

func buildMenu(devices []Device) string {
	var lines []string

	lines = append(lines, toggleOff)
	lines = append(lines, "──────────────")

	for _, device := range devices {
		icon := iconDisconnected

		if device.Connected {
			icon = iconConnected
		}

		lines = append(lines, fmt.Sprintf("%s  %s", icon, device.Name))
	}

	return strings.Join(lines, "\n")
}

func rofi(menu string) (string, error) {
	theme := os.Getenv("HOME") + "/.config/waybar/scripts/menu.rasi"

	cmd := exec.Command(
		"rofi",
		"-dmenu",
		"-i",
		"-p",
		"Bluetooth",
		"-theme",
		theme,
	)

	cmd.Stdin = strings.NewReader(menu)

	out, err := cmd.Output()
	if err != nil {
		return "", err
	}

	return strings.TrimSpace(string(out)), nil
}

func findDeviceByName(devices []Device, name string) *Device {
	for i := range devices {
		if devices[i].Name == name {
			return &devices[i]
		}
	}

	return nil
}

func connectDevice(device *Device) {
	if device.Connected {
		_, _ = run("bluetoothctl", "disconnect", device.MAC)
		return
	}

	// Try connecting first.
	cmd := exec.Command("bluetoothctl", "connect", device.MAC)

	if err := cmd.Run(); err == nil {
		return
	}

	// If connection failed, pair and try again.
	_, _ = run("bluetoothctl", "pair", device.MAC)
	_, _ = run("bluetoothctl", "connect", device.MAC)
}

func main() {
	for {
		if bluetoothPowered() {
			stopScan := startScan()

			time.Sleep(2 * time.Second)

			devices := getDevices()

			stopScan()

			menu := buildMenu(devices)

			choice, err := rofi(menu)
			if err != nil {
				return
			}

			switch choice {
			case toggleOff:
				_, _ = run("bluetoothctl", "power", "off")
				continue

			case "":
				return
			}

			// Remove the connection status icon.
			name := strings.TrimPrefix(choice, iconConnected+"  ")
			name = strings.TrimPrefix(name, iconDisconnected+"  ")

			device := findDeviceByName(devices, name)

			if device == nil {
				continue
			}

			connectDevice(device)

			time.Sleep(time.Second)

		} else {
			choice, err := rofi(toggleOn)
			if err != nil {
				return
			}

			switch choice {
			case toggleOn:
				_, _ = run("bluetoothctl", "power", "on")
				time.Sleep(time.Second)

			case "":
				return
			}
		}
	}
}
