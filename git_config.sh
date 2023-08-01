#!/bin/bash

globals_config() {
    # Prompt for username
    echo "Please enter your GitHub username:"
    read username

    # Prompt for email
    echo "Please enter your GitHub email:"
    read email

    # Set username and email globally for git
    git config --global user.name "$username"
    git config --global user.email "$email"

    echo "Git configuration successfully updated. Your username is $username and your email is $email."
}

generate_and_add_ssh() {
    # Prompt for email
    echo "Please enter your email address:"
    read email

    # Generate a new SSH key
    ssh-keygen -t ed25519 -C "$email"

    # Start the ssh-agent in the background and add your SSH private key
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519

    # Print the public key
    echo "Your public key is:"
    cat ~/.ssh/id_ed25519.pub
}

while true; do
    echo "1. Configure git globals"
    echo "2. Generate and add SSH key"
    echo "3. Exit"
    read -p "Please select an option: " selection

    case $selection in
        1)
            globals_config
            ;;
        2)
            generate_and_add_ssh
            ;;
        3)
            echo "Exiting..."
            exit
            ;;
        *)
            echo "Invalid option. Please enter 1, 2 or 3."
            ;;
    esac
done










