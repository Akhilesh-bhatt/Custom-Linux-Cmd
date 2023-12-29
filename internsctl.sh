#!/bin/bash

command_name="internsctl"
command_version="v0.1.0"

function man_page() {
    echo "MANUAL PAGE FOR $command_name"
    echo "-----------------------------"
    # Replace this with your actual manual content
    echo "Here's the full documentation for the $command_name command."
    echo "Detailed usage guidelines and examples should be provided here."
}

function help_message() {
    echo "USAGE: $command_name [OPTION]"
    echo "Options:"
    echo "  --help     Display this help message."
    echo "  --version  Display the version of the command."
    echo "Subcommands:"
    echo "  cpu getinfo    Display CPU information."
    echo "  memory getinfo Display memory information."
    echo "  user create    Create a new user."
    echo "  user list      List regular users."
    echo "  user list --sudo-only List users with sudo permissions."
    echo "  file getinfo  [options] <filename> Get file information."
    echo "    Options: --size, -s  Print size"
    echo "             --permissions, -p Print file permissions"
    echo "             --owner, -o Print file owner"
    echo "             --last-modified, -m Print last modified time"
}

function cpu_getinfo() {
    lscpu
}

function memory_getinfo() {
    free
}

function user_create() {
    read -sp "Enter username: " username
    read -sp "Enter password: " password
    useradd -m -s /bin/bash "$username"
    echo "$password" | passwd --stdin "$username"
}

function user_list() {
    getent passwd
}

function user_list_sudo_only() {
    getent passwd | grep -E '^[^:]+:[^:]+:0:'
}

function file_getinfo() {
    local filename="$1"
    local options=()

    while [[ $# -gt 1 ]]; do
        case "$2" in
            --size | -s)
                options+=(size)
                ;;
            --permissions | -p)
                options+=(permissions)
                ;;
            --owner | -o)
                options+=(owner)
                ;;
            --last-modified | -m)
                options+=(last_modified)
                ;;
            *)
                echo "Unknown option: <span class="math-inline">2"
help\_message
return 1
;;
esac
shift 2
done
owner\=</span>(stat -c %U "<span class="math-inline">filename"\)
permissions\=</span>(stat -c %A "<span class="math-inline">filename"\)
size\=</span>(stat -c %s "<span class="math-inline">filename"\)
last\_modified\=</span>(date +"%Y-%m-%d %H:%M:%S %:z" --reference="$filename")

    if [[ ${#options[@]} -eq 0 ]]; then
        printf "File: %s\nAccess: %s\nSize(B): %s\nOwner: %s\nModify: %s\n" \
            "$filename" "$permissions" "$size" "$owner" "<span class="math-inline">last\_modified"
else
for option in "</span>{options[@]}"; do
            case "$option" in
                size)
                    echo "$size"
                    ;;
                permissions)
                    echo "$permissions"
                    ;;
                owner)
                    echo "$owner"
                    ;;
                last_modified)
                    echo "$last_modified"
                    ;;
            esac
        done
    fi
}

case "$1" in
    --help)
        help_message
        ;;
    --version)
        echo "$command_name $command_version"
        ;;
    cpu)
        shift
        case "$1" in
            getinfo)
                cpu_getinfo
                ;;
            *)
                echo "Unknown CPU subcommand: $1"
                help_message
                ;;
        esac
        ;;
    memory)
