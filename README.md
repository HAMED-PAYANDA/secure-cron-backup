# 🛡️ Secure Cron Backup: Automated POSIX Archive Utility

![IBM](https://img.shields.io/badge/IBM-Applied_Software_Engineering_Fundamentals-052FAD?style=flat&logo=ibm&logoColor=white)
![IBM Linux Commands](https://img.shields.io/badge/IBM-Linux_Commands-052FAD?style=flat&logo=ibm&logoColor=white)
![Shell Scripting](https://img.shields.io/badge/Shell-Scripting-4EAA25?style=flat&logo=gnu-bash&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat&logo=github-actions&logoColor=white)
![ShellCheck](https://img.shields.io/badge/ShellCheck-Static_Analysis-lightgrey?style=flat)
![Status](https://img.shields.io/badge/Status-Completed-success?style=flat)

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
graph TD
    A[Cron Daemon] -->|Executes @ Midnight| B(backup.sh Utility)
    B -->|Scans File Metadata| C{Epoch Time Validator}
    C -->|Validates < 24h Modified| D[Array Parser]
    D -->|Feeds Safe File List| E(Tar Archiver)
    E -->|Compresses & Moves .tar.gz| F[Destination Directory]
    
    G[GitHub Push/PR] -.->|Triggers CI/CD| H{GitHub Actions}
    H -.->|Enforces POSIX standard| I[ShellCheck Linter]

    classDef sys fill:#2b3137,stroke:#333,stroke-width:2px,color:#fff;
    classDef bash fill:#4EAA25,stroke:#333,stroke-width:2px,color:#fff;
    classDef logic fill:#2088FF,stroke:#333,stroke-width:2px,color:#fff;
    classDef storage fill:#8e44ad,stroke:#333,stroke-width:2px,color:#fff;
    classDef ci fill:#052FAD,stroke:#333,stroke-width:2px,color:#fff;

    class A sys;
    class B bash;
    class C,D logic;
    class E,F storage;
    class G,H,I ci;
```

---

## ✨ Key Features
* **Rolling 24-Hour Window (Epoch Validation):** Uses epoch timestamps (seconds since Jan 1, 1970) and arithmetic expansion to calculate exact 24-hour thresholds, ensuring absolute accuracy across date boundaries and timezones.
* **POSIX-Compliant Array Parsing:** Utilizes strict array expansion (`${toBackup[@]}`) to safely handle dynamic file lists, preventing word-splitting issues with filenames containing spaces or special characters.
* **Zero-Error Execution Guardrails:** Explicit validation checks ensure directory arguments exist and are accessible before execution, exiting cleanly with standard error codes if parameters are missing.
* **Automated CI/CD Linting:** Integrated GitHub Actions workflow (`shellcheck.yml`) automatically sets up the environment and enforces strict POSIX/Bash compliance on every push.
* **Background Automation:** Engineered for seamless daemon scheduling via cron without requiring manual user intervention.

---

## 🧰 Core Tech Stack

| Category | Technology / Tool | Version | Language |
| :--- | :--- | :--- | :--- |
| **Scripting** | GNU Bash | 5.0+ | Bash |
| **Archival** | Tar (Tape Archive) | Standard | - |
| **Automation** | Cron Daemon | Standard | - |
| **DevOps & CI/CD** | GitHub Actions | - | YAML |
| **Static Analysis** | ShellCheck | Action v2.0 | - |
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

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👤 Author

**Hamed Payanda**
* **GitHub:** [@HAMED-PAYANDA](https://github.com/HAMED-PAYANDA)
* Developed as part of the **IBM Applied Software Engineering program**.
