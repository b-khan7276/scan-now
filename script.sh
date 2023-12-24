#!/bin/bash

# Programs to check and install if not found
programs=("lynis" "tiger" "rkhunter" "ufw" "clamscan")

# Output file path
output_file="$HOME/Desktop/system_audit_results.txt"

# Descriptions for each command and software
descriptions=(
    "Lynis is an open-source security auditing tool. 'sudo lynis audit system' performs system audits."
    "Tiger is a security tool that checks common security issues on a system. 'sudo tiger' performs system checks."
    "rkhunter is a rootkit detection tool. 'sudo rkhunter --check' checks the system for rootkits."
    "UFW (Uncomplicated Firewall) is a front-end for managing netfilter firewall rules. Configures firewall rules."
    "ClamAV is an antivirus software. 'clamscan -r ~' scans the home directory recursively for viruses."
)

# Function to display descriptions
display_descriptions() {
    for ((i=0; i<${#programs[@]}; i++)); do
        echo "--------------------------------"
        echo "${programs[i]}: ${descriptions[i]}"
        echo "--------------------------------"
    done
}

# Function to run a program and log output
run_and_log() {
    program=$1
    action=$2

    echo "--------------------------------"
    echo "Running $program $action..."
    echo "*********** $program ***********" >> "$output_file"
    $program $action >> "$output_file" 2>&1
    echo "--------------------------------" >> "$output_file"
    echo "Completed $program $action"
}

# Check and install programs if not found
for program in "${programs[@]}"; do
    if ! command -v "$program" &> /dev/null; then
        echo "$program not found. Installing..."
        sudo apt-get install -y "$program"
    fi
done

# Display descriptions before executing commands
display_descriptions

# Run each program with specified action
for program in "${programs[@]}"; do
    case $program in
        lynis)
            run_and_log "sudo" "lynis audit system"
            ;;
        tiger)
            run_and_log "sudo" "tiger"
            ;;
        rkhunter)
            run_and_log "sudo" "rkhunter --check"
            ;;
        ufw)
            display_descriptions
            sudo ufw default deny incoming
            sudo ufw default allow outgoing
            sudo ufw enable
            echo "UFW configured to deny all incoming connections and allow all outgoing connections."
            echo "UFW configured to deny all incoming connections and allow all outgoing connections." >> "$output_file"
            ;;
        clamscan)
            run_and_log "clamscan" "-r ~"
            ;;
        *)
            echo "Unknown program: $program"
            ;;
    esac
done

echo "Audit completed. Results saved to $output_file"
