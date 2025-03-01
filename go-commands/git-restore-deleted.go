package main

import (
	"fmt"
	"os"
	"os/exec"

	"golang.org/x/term"
)

func main() {
	// this uses the { ... } is used to group multiple commands together; ensuring they execute
	// in the same shell and their combined output is passed as a single stream to xargs.
	command := `
		{ git diff --diff-filter=D --name-only -z; git diff --cached --diff-filter=D --name-only -z; } | xargs -0 -I {} git checkout HEAD "{}"
	`

	// Print command in bright black color
	fmt.Println("\033[90;1mThis will run: " + command + "\033[0m")

	fmt.Print("Are you sure? [Yn] ")

	// Save the current terminal state
	oldState, err := term.GetState(int(os.Stdin.Fd()))
	if err != nil {
		fmt.Println("\nError getting terminal state:", err)
		return
	}

	// Ensure the terminal is restored on exit
	defer func() {
		term.Restore(int(os.Stdin.Fd()), oldState)
	}()

	// Set terminal to raw mode to capture a single key press
	if _, err := term.MakeRaw(int(os.Stdin.Fd())); err != nil {
		fmt.Println("\nError setting raw mode:", err)
		return
	}

	// Read a single key press
	var b [1]byte
	_, _ = os.Stdin.Read(b[:]) // Read one byte (key press)

	// Restore terminal before waiting for Enter
	term.Restore(int(os.Stdin.Fd()), oldState)

	// Check input and execute command if confirmed
	if b[0] == 'y' || b[0] == 'Y' {
		fmt.Println("Running command...")

		cmd := exec.Command("sh", "-c", command)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr

		if err := cmd.Run(); err != nil {
			fmt.Println("Error executing command:", err)
			os.Exit(1)
		} else {
			fmt.Println("Done.")
		}
	} else {
		fmt.Println("\nCancelled.")
		os.Exit(1)
	}
}
