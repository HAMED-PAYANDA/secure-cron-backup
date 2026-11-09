# 🛡️ Secure Cron Backup: Automated POSIX Archive Utility

![IBM](https://img.shields.io/badge/IBM-Applied_Software_Engineering_Fundamentals-052FAD?style=for-the-badge&logo=ibm&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)
![ShellCheck](https://img.shields.io/badge/ShellCheck-Static_Analysis-lightgrey?style=for-the-badge)

---

## 📖 Project Overview
This project provides a production-ready, POSIX-compliant Bash utility designed to securely archive time-sensitive infrastructure files. The application automates the daily extraction and backup of secure server assets by isolating files modified within a rolling 24-hour window, compressing them into a timestamped tarball, and safely transferring them to a designated destination. It features automated CI/CD linting via GitHub Actions to ensure strict syntax safety and reliable execution in enterprise environments.

---

## 📸 Visual Proof & Demos
Here is a look at the automation configuration in action:
1. Automated Cron Scheduling
Demonstrates the background daemon configuration executing the script at midnight daily.
**Automated Cron Scheduling (System Daemon)**
![Cron Schedule](crontab.png)

---

## 🏗️ Architecture Diagram
The utility follows a linear, validation-first execution flow, triggered by the system's cron daemon and protected by continuous integration.

```mermaid
[Cron Daemon] ──(Triggers Daily @ Midnight)──> [backup.sh]
                                                    │
                                             (Epoch Validation)
                                                    │
[Target Directory] ──(Filters < 24h files)──> [Array Parser]
                                                    │
                                             (Tar Compression)
                                                    │
[Destination Dir] <──(Moves backup.tar.gz)─── [Archiver]

===============================================================
[GitHub Repository] <──(Push/PR)──> [GitHub Actions: ShellCheck]
```

---

## ✨ Key Features
Rolling 24-Hour Window (Epoch Validation): Uses epoch timestamps (seconds since Jan 1, 1970) and arithmetic expansion to calculate exact 24-hour thresholds, ensuring absolute accuracy across date boundaries and timezones.
POSIX-Compliant Array Parsing: Utilizes strict array expansion (${toBackup[@]}) to safely handle dynamic file lists, preventing word-splitting issues with filenames containing spaces or special characters.
Zero-Error Execution Guardrails: Explicit validation checks ensure directory arguments exist and are accessible before execution, exiting cleanly with standard error codes if parameters are missing.
Automated CI/CD Linting: Integrated GitHub Actions workflow (shellcheck.yml) automatically sets up the environment and enforces strict POSIX/Bash compliance on every push.
Background Automation: Engineered for seamless daemon scheduling via cron without requiring manual user intervention.

---

🧰 Core Tech Stack
Category	Technology / Tool	Version	Language
Scripting	GNU Bash	5.0+	Bash
Archival	Tar (Tape Archive)	Standard	-
Automation	Cron Daemon	Standard	-
DevOps & CI/CD	GitHub Actions	-	YAML
Static Analysis	ShellCheck	Action v2.0	-

---

## 📂 Repository Structure
```Plaintext
.
├── .github/
│   └── workflows/
│       └── shellcheck.yml     # CI/CD Pipeline Configuration
├── backup.sh                  # Script: Automated POSIX Archive Utility
├── crontab.png                # Image Asset: Cron schedule configuration
└── README.md                  # Project Documentation
```

---

## 💻 Local Setup & Execution
Want to deploy this utility on your own server or machine? Follow these steps:
1. Clone the repository
```Bash
git clone https://github.com/HAMED-PAYANDA/secure-cron-backup.git
cd secure-cron-backup
```
2. Make the script executable
```Bash
chmod u+x backup.sh
```
3. Deploy to a secure system directory
```Bash
sudo cp backup.sh /usr/local/bin/
```
4. Execute Manually
The utility requires two arguments: the target directory to scan, and the destination directory for the archive.
```Bash
backup.sh /path/to/target /path/to/destination
```
5. Configure Cron Scheduling
To schedule daily backups at midnight system time, append the following directive to your crontab (crontab -e):
```Bash
0 0 * * * /usr/local/bin/backup.sh /path/to/target /path/to/destination
```

---

📄 License
This project is licensed under the MIT License.

---

👤 Author
Hamed Payanda
GitHub: @HAMED-PAYANDA
Completed as a core automation project for the IBM Full Stack Software Developer program.
