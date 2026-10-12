package main

import (
	"os"
	"os/exec"
	"strings"
)

type Profile struct {
	Name   string
	Active bool
}

func run(name string, args ...string) (string, error) {
	cmd := exec.Command(name, args...)

	out, err := cmd.Output()
	if err != nil {
		return "", err
	}

	return string(out), nil
}

func rofi(menu string) (string, error) {
	theme := os.Getenv("HOME") + "/.config/waybar/scripts/menu.rasi"

	cmd := exec.Command(
		"rofi",
		"-dmenu",
		"-i",
		"-p",
		"Power",
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

func buildMenu(profiles []Profile) string {
	var input strings.Builder

	for _, profile := range profiles {
		name := profile.Name

		if profile.Active {
			name += " ●"
		}

		input.WriteString(name)
		input.WriteByte('\n')
	}

	return input.String()
}

func getPowerProfiles() (string, error) {
	return run("powerprofilesctl", "list")
}

func selectProfile(choice string, profiles []Profile) error {
	choice = strings.TrimSuffix(choice, " ●")

	for _, profile := range profiles {
		if choice == profile.Name {
			_, err := run("powerprofilesctl", "set", profile.Name)
			return err
		}
	}

	return nil
}

func parseProfiles(output string) []Profile {
	var profiles []Profile

	for line := range strings.SplitSeq(output, "\n") {
		line = strings.TrimSpace(line)

		if line == "" {
			continue
		}

		active := strings.HasPrefix(line, "*")

		line = strings.TrimPrefix(line, "*")
		line = strings.TrimSpace(line)

		if !strings.HasSuffix(line, ":") {
			continue
		}

		name := strings.TrimSuffix(line, ":")

		profiles = append(profiles, Profile{
			Name:   name,
			Active: active,
		})
	}

	return profiles
}

func main() {
	for {
		profilesRaw, err := getPowerProfiles()
		if err != nil {
			return
		}

		profiles := parseProfiles(profilesRaw)
		menu := buildMenu(profiles)

		choice, err := rofi(menu)
		if err != nil {
			return
		}

		if choice == "" {
			return
		}

		if err := selectProfile(choice, profiles); err != nil {
			return
		}
	}
}
