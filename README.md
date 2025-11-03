# 🕒 EasyCron — Simplify Linux Task Scheduling

### ✨ A Beginner-Friendly Task Scheduler for Linux Users

EasyCron is a simple **Bash-based tool** that helps beginners easily create and manage scheduled tasks on Linux without manually editing the `crontab` configuration file.

---

## 🚀 About EasyCron

Many new Linux users struggle to set up scheduled tasks using `crontab`.  
EasyCron provides a **user-friendly terminal interface** that guides you step-by-step to create scheduled jobs — no need to remember cron syntax!

It automatically:
- Prompts the user for timing (daily, weekly, monthly, or custom)
- Validates the input and file path
- Adds the correct cron entry to the system crontab

> 🧠 Ideal for beginners who want to automate scripts or commands easily without touching cron syntax.

---

## 💡 Features

✅ Interactive and beginner-friendly  
✅ Safe file path validation  
✅ Supports multiple schedule types  
✅ Automatically appends valid entries to crontab  
✅ Clean and colored output messages  
✅ Error handling for invalid or empty fields  

---

## 🧰 Requirements

- Linux (any distro)
- Bash shell
- `cron` service installed and running
- Basic permissions to edit crontab

---

## ⚙️ Installation

Clone the repository:
```bash
git clone https://github.com/Redinit/EasyCron.git
cd EasyCron
chmod +x easycron.sh
```

## 🖥️ Usage

Run EasyCron:
```bash
./easycron.sh
```
Follow the on-screen instructions:

- Enter the full path of your script or command.

- Choose when it should run:

- Every day

- Every week

- Every month

- Custom time (minute/hour/day/month/week)

- EasyCron automatically validates and adds the entry to your crontab.
### Example
```bash
Cron Entry Preview: 0 8 * * * /home/user/scripts/backup.sh
```

## 📘 Output Preview
```bash
============================================================================
                          Welcome To EasyCron!   
            EasyCron: Easy Way To Make Scheduled Tasks In Linux             
============================================================================

Enter full Path(command/script): /home/user/hello.sh
When Should This Task Runs?
1) Every Day
2) Every Week
3) Every Month
4) Custom Time
Choose(1-4): 1

Task Successfully Added
Cron Entry: 0 8 * * * /home/user/hello.sh
You Can Verify Using: crontab -l

```

---
### 🛣️ Roadmap & Known Issues 🛠️

We are actively working to improve EasyCron. Here are the known limitations and features planned for future releases:

* **Input Validation:** Currently, custom time inputs (e.g., minute: 60) are not validated against the correct numeric range. We plan to implement full range checking soon.
* **Path Retry:** If a file path is entered incorrectly, the script currently exits. We plan to update the script to allow users to retry path entry.
* **Removal Feature:** Adding a feature to easily remove scheduled tasks via the tool.

---

## 🧑‍💻 About the Creator

Hi, I’m Redinit (A.K.A Viswajith), a beginner learning Bash scripting and Linux.
I created EasyCron to make scheduling tasks simple for new users like me.

While learning, I faced confusion with cron syntax — so I built this tool by combining my logic, research, and help from ChatGPT and other online resources.
Even as a beginner, I understood every line of my script and improved step by step.

💬 My message to other beginners:
Don't feel bad about making mistakes or asking for help.
Every developer learns by doing, failing, and improving.
Keep going — you’ll become a pro one day too! 🚀
