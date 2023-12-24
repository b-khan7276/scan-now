# Scan-now

This Bash script automates system auditing by installing and running various security tools and commands. It performs checks using tools like Lynis, Tiger, rkhunter, UFW, and ClamAV to assess system security, firewall settings, rootkit detection, and antivirus scanning.

## Features

- Installs necessary security tools if not found on the system.
- Executes specific commands for system auditing using the installed tools.
- Displays descriptions of each tool and action performed during the audit.

## How to Use

### Prerequisites

- This script is designed for Linux systems using the Bash shell.
- Ensure you have appropriate permissions to install packages and configure firewall settings (requires sudo).

### Running the Script

1. Clone or download this repository to your local machine.
2. Navigate to the directory where the script (`system_audit.sh`) is located.
3. Ensure the script has executable permissions:
    ```bash
    chmod +x scan-now.sh
    ```
4. Run the script:
    ```bash
    ./system_audit.sh
    ```
5. Follow on-screen instructions if prompted for sudo password during execution.

## Output

- The results of the system audit will be displayed in the terminal during execution.
- Detailed audit logs will be saved to a file named `system_audit_results.txt` & `system_audit_results.html` on the Desktop.

## Disclaimer

- This script is provided as-is and should be used with caution. Understand the actions it performs before execution.
