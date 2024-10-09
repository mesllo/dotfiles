#!/bin/bash

# Path to the modules directory
modules_dir="modules"

# Path to the primary script inside the modules directory
primary_script="$modules_dir/general_install.sh"

exclude_list=("general_install.sh", "docker_uninstall.sh")

# Check if the modules directory exists
if [[ ! -d "$modules_dir" ]]; then
    echo "Error: Modules directory $modules_dir not found."
    exit 1
fi

sudo apt update
sudo apt upgrade

# Check and run the primary script first
if [[ -x "$primary_script" ]]; then
    echo "Running $primary_script..."
    ./"$primary_script"
    if [[ $? -ne 0 ]]; then
        echo "Error: $primary_script failed to execute."
        exit 1
    fi
else
    echo "Error: $primary_script is not executable or not found."
    exit 1
fi

# Iterate over all shell scripts in the modules directory and run each one, except for the excluded ones
for script in "$modules_dir"/*.sh; do
    if [[ "$script" == *"${exclude_list[@]}"* ]]; then
        continue
    fi
    if [[ -x "$script" ]]; then
        sudo apt update
        sudo apt upgrade
        echo "Running $script..."
        ./"$script"
        if [[ $? -ne 0 ]]; then
            echo "Error: $script failed to execute."
            exit 1
        fi
    else
        echo "Error: $script is not executable or not found."
    fi
done

source ~/.bashrc

echo "All scripts executed successfully."