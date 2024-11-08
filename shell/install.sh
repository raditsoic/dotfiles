#!/bin/bash

default="bash"
shell=$default 

# Parse command-line options
while getopts ":s:" option; do
    case $option in
        s)
            shell=$OPTARG
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

# Check for supported shell types
if [[ "$shell" != "bash" && "$shell" != "zsh" ]]; then
    echo "Unsupported shell type: $shell. Use 'bash' or 'zsh'."
    exit 1
fi

# Install zsh if selected and not already installed
if [[ "$shell" == "zsh" ]]; then
    if ! command -v zsh &> /dev/null; then
        echo "Installing zsh..."
        sudo apt install -y zsh
        echo "Zsh installed successfully."
    else
        echo "Zsh is already installed."
    fi
elif [[ "$shell" == "bash" ]]; then
    echo "Using bash... for now."
fi

# Check current shell and change only if different
if [[ "$SHELL" != "$(which $shell)" ]]; then
    echo "Changing the shell to $shell..."
    chsh -s "$(which $shell)"
    echo "Shell changed to $shell successfully!"
else
    echo "Shell is already set to $shell."
fi
