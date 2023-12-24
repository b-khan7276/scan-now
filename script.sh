#!/bin/bash

# Programs to check and install if not found
programs=("lynis" "tiger" "rkhunter" "ufw" "clamscan")

# Output file paths
output_txt="$HOME/Desktop/system_audit_results.txt"
output_html="$HOME/Desktop/system_audit_results.html"

# Descriptions for each command and software
descriptions=(
    "Lynis is an open-source security auditing tool. 'sudo lynis audit system' performs system audits."
    "Tiger is a security tool that checks common security issues on a system. 'sudo tiger' performs system checks."
    "rkhunter is a rootkit detection tool. 'sudo rkhunter --check' checks the system for rootkits."
    "UFW (Uncomplicated Firewall) is a front-end for managing netfilter firewall rules. Configures firewall rules."
    "ClamAV is an antivirus software. 'clamscan -r ~' scans the home directory recursively for viruses."
)

# Commands for running each program
commands=(
    "sudo lynis audit system"
    "sudo tiger"
    "sudo rkhunter --check --verbose"
    "sudo ufw status verbose"
    "clamscan -r ~ --verbose"
)

# Function to display descriptions
display_descriptions() {
    echo "Available Scans:"
    for ((i=0; i<${#programs[@]}; i++)); do
        echo "--------------------------------"
        echo "$(($i+1))) ${programs[i]}: ${descriptions[i]}"
    done
    echo "--------------------------------"
    echo "0) Run all scans"
}

# Function to run a program and log output
run_and_log() {
    program=$1
    action=$2

    echo "--------------------------------"
    echo "Running $program..."
    echo "*********** $program ***********"
    echo "--------------------------------"

    eval "$action" | tee -a "$output_txt" | tee -a "$output_html"

    echo "--------------------------------"
    echo "Completed $program"
}

# Check and install programs if not found
for program in "${programs[@]}"; do
    if ! command -v "$program" &> /dev/null; then
        echo "$program not found. Installing..."
        sudo apt-get install -y "$program"
    fi
done

# Create HTML file with basic structure
echo "<html><head><title>System Audit Results</title></head><body>" > "$output_html"

# Display descriptions and get user input
display_descriptions
read -p "Choose a scan (0 for all): " choice

# Run selected scan(s)
if [ "$choice" -eq 0 ]; then
    for ((i=0; i<${#programs[@]}; i++)); do
        run_and_log "${programs[$i]}" "${commands[$i]}"
    done
elif [ "$choice" -ge 1 ] && [ "$choice" -le "${#programs[@]}" ]; then
    index=$((choice-1))
    run_and_log "${programs[$index]}" "${commands[$index]}"
else
    echo "Invalid choice."
fi

# Close HTML file
echo "</body></html>" >> "$output_html"

echo "Audit completed. Results saved to $output_txt and $output_html"
