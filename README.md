
# 🔁 Link And IP Loop

A Termux-compatible Bash script with 4 main options:  
- Reopen URL repeatedly  
- Repeated connect to IP:Port  
- Fast open host:port flood  
- Search person by name online  

Supports English and Russian languages.

---

## 🚀 Features

- Simple menu-driven interface in Termux  
- Customizable speed and pause options  
- Uses `netcat` for connection tests and floods  
- Opens URLs and search results using `termux-open-url`  
- Multi-language support (English, Russian)

---

## ⚙️ Installation

1. Clone this repository:

`
git clone https://github.com/zhobinalex/LinkAndIPLoop.git

cd LinkAndIPLoop

bash install_link_and_ip_loop.sh

$HOME/LinkAndIPLoop/link_and_ip_loop.sh

Creates a working folder with needed .txt files

Adds a demo Git link (which you can replace later)

Asks the user for language: English 🇬🇧, Russian 🇷🇺

Displays the script name in a styled header

Prepares everything to run cleanly on Termux


---

🔹 Option 1: Reopen a URL repeatedly

User sets URL, speed (seconds), and optional pause time (minutes).

The script opens the URL repeatedly using termux-open-url.



---

🔹 Option 2: Repeated connect to IP and port

User inputs IP and port.

Sets speed (delay in seconds).

Script tries connecting (via TCP) continuously without pause.



---

🔹 Option 3: Reopen IP:Port, Host:Port, or Subdomain:Port VERY FAST

User enters IP/host/subdomain + port.

The script sends extremely fast connections (like a flood/ping).

Goal: Fast repeated access simulation — using either:

curl, wget, or nc (netcat)

or /dev/tcp for low overhead




---

🔹 Option 4: Person Finder

User provides first name + last name

Script performs internet search using various search engines or APIs (as much as possible from Termux)

Goal: Give back info about the person from public data

