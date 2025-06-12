#!/data/data/com.termux/files/usr/bin/bash

# Installer for Link And IP Loop

clear
echo "====================================="
echo "       🔁 LINK AND IP LOOP 🔁        "
echo "====================================="

echo "Select your language:"
echo "1 - English"
echo "2 - Russian"
read -p "Choose [1-2]: " lang_choice

case $lang_choice in
  1) lang="EN";;
  2) lang="RU";;
  *) lang="EN";;
esac

WORK_DIR="$HOME/LinkAndIPLoop"
DEMO_GIT_LINK="https://github.com/zhobinalex/LinkAndIPLoop"

mkdir -p "$WORK_DIR"
touch "$WORK_DIR/urls.txt"
touch "$WORK_DIR/ips.txt"
touch "$WORK_DIR/log.txt"

echo "[*] Installing required packages..."
pkg update -y
pkg install -y openssh curl git netcat termux-api

# Request storage permissions (for termux-open-url)
termux-setup-storage

# Create main script
cat > "$WORK_DIR/link_and_ip_loop.sh" << EOF
#!/data/data/com.termux/files/usr/bin/bash

clear
echo "====================================="
echo "       🔁 LINK AND IP LOOP 🔁        "
echo "====================================="

menu() {
  if [ "$lang" = "RU" ]; then
    echo "1. Повторно открыть URL"
    echo "2. Повторное подключение к IP:Порт"
    echo "3. Быстрый флууд на host:port"
    echo "4. Поиск человека"
    echo "0. Выйти"
    read -p "Выберите опцию [0-4]: " choice
  else
    echo "1. Reopen URL repeatedly"
    echo "2. Repeated connect to IP:Port"
    echo "3. Fast open host:port flood"
    echo "4. Search person"
    echo "0. Exit"
    read -p "Choose option [0-4]: " choice
  fi

  case \$choice in
    1) repeat_open_url ;;
    2) connect_ip_port ;;
    3) fast_connect ;;
    4) find_person ;;
    0) exit 0 ;;
    *) echo "Invalid option"; sleep 1; menu ;;
  esac
}

repeat_open_url() {
  read -p "Enter URL (e.g., google.com or https://example.com): " url

  # Auto-add https:// if not already included
  if [[ ! "$url" =~ ^https?:// ]]; then
    url="https://$url"
  fi

  echo "[*] Final URL: $url"
  read -p "Speed (seconds between opens): " speed
  read -p "Pause time (minutes between bursts): " pause_minutes
  pause_seconds=$((pause_minutes * 60))

  echo "[*] Starting loop... Press Ctrl+C to stop."

  while true; do
    termux-open-url "$url"
    sleep "$speed"

    if [ "$pause_seconds" -gt 0 ]; then
      echo "[*] Pausing for $pause_seconds seconds..."
      sleep "$pause_seconds"
    fi
  done
}
connect_ip_port() {
  if [ "\$lang" = "RU" ]; then
    read -p "Введите IP: " ip
    read -p "Введите порт: " port
    read -p "Скорость (секунды): " speed
  else
    read -p "Enter IP: " ip
    read -p "Enter Port: " port
    read -p "Speed (seconds): " speed
  fi

  while true; do
    if nc -z "\$ip" "\$port" >/dev/null 2>&1; then
      echo "[✓] OK"
    else
      echo "[!] Fail"
    fi
    sleep "\$speed"
  done
}

fast_connect() {
  if [ "\$lang" = "RU" ]; then
    read -p "Хост/IP: " host
    read -p "Порт: " port
    echo "Отправка флуда на \$host:\$port (Ctrl+C для остановки)"
  else
    read -p "Host/IP: " host
    read -p "Port: " port
    echo "Sending flood to \$host:\$port (press Ctrl+C to stop)"
  fi

  while true; do
    nc -z "\$host" "\$port" >/dev/null 2>&1
    sleep 0.1
  done
}

find_person() {
  if [ "\$lang" = "RU" ]; then
    read -p "Имя: " fname
    read -p "Фамилия: " lname
  else
    read -p "First name: " fname
    read -p "Last name: " lname
  fi

  search_url="https://www.google.com/search?q=\${fname}+\${lname}"
  termux-open-url "\$search_url"
  if [ "\$lang" = "RU" ]; then
    echo "Открыт браузер для поиска."
  else
    echo "Opened browser for search."
  fi
}

menu
EOF

chmod +x "$WORK_DIR/link_and_ip_loop.sh"

echo
if [ "$lang" = "RU" ]; then
  echo "✅ Установка завершена!"
  echo "👉 Запустите скрипт:"
  echo "   bash $WORK_DIR/link_and_ip_loop.sh"
else
  echo "✅ Installation complete!"
  echo "👉 Run the script with:"
  echo "   bash $WORK_DIR/link_and_ip_loop.sh"
fi
echo
echo "🌐 GitHub Demo Link: $DEMO_GIT_LINK"
echo "📂 Workspace: $WORK_DIR"
echo "📄 Files: urls.txt, ips.txt, log.txt"
