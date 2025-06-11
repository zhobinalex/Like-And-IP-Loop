Thank you for detailing your requirements! Here’s a breakdown of what you want in your Termux setup script:

---

## **Requirements Recap**

**Header:**  
- Display: “open bar”
- Inject “Source by zhobinalex”

**Option 1:**  
- A panel to enter a URL and a timer (seconds or minutes)  
- Automatically open the URL at the set interval (repeatable)

**Option 2:**  
- A panel to search for music by name, title, or artist on www.radiojavan.com  
- User writes a query and clicks a “search” button to view results

---

## **Key Notes**
- Termux is terminal-based, so “panels” and “buttons” would be command-line menus or prompts.
- For opening URLs, Termux uses `am start` (for Android browsers).
- For music search, we’d use `curl` or `wget` to fetch search results (parsing HTML or using any available API).
- Script header and credits will be displayed on launch.

---


https://github.com/zhobinalex/Soorino-/blob/main/READMEw.md

## **Full Bash Script for Termux**

```bash
#!/data/data/com.termux/files/usr/bin/bash

# Header
clear
echo "================================="
echo "         open bar"
echo "================================="
echo "Source by zhobinalex"
echo "================================="

# Install required packages
echo "[*] Installing required packages..."
pkg update -y
pkg install git openssh curl -y

main_menu() {
    echo ""
    echo "Select an option:"
    echo "1) Auto-open a URL at set intervals"
    echo "2) Search music on radiojavan.com"
    echo "3) Exit"
    read -p "Enter your choice [1-3]: " choice

    case "$choice" in
        1) option1 ;;
        2) option2 ;;
        3) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid choice!"; main_menu ;;
    esac
}

option1() {
    read -p "Enter the URL to open: " url
    read -p "Interval (number): " interval
    read -p "Time unit (s = seconds, m = minutes): " unit
    if [[ "$unit" == "m" ]]; then
        interval=$((interval*60))
    fi
    echo "Opening $url every $interval seconds. Press CTRL+C to stop."
    while true; do
        am start -a android.intent.action.VIEW -d "$url"
        sleep "$interval"
    done
}

option2() {
    read -p "Enter song name, title, or artist to search: " query
    search_url="https://www.radiojavan.com/mp3s/mp3_search?q=$(echo "$query" | sed 's/ /%20/g')"
    echo "Searching RadioJavan.com for '$query'..."
    echo "-------------------------------------------"
    curl -s "$search_url" | grep -Eo '<a href="/mp3s/mp3/[^"]+"' | head -10 | while read -r line; do
        song_page="https://www.radiojavan.com$(echo $line | cut -d'"' -f2)"
        title=$(curl -s "$song_page" | grep -oP '(?<=<title>).*?(?=</title>)')
        echo "$title"
        echo "Link: $song_page"
        echo "---------------------------"
    done
    echo "Done."
}

while true; do
    main_menu
done
```

---

## **How to Use**

1. **Save the script** as `openbar.sh`
2. Run:
   ```bash
   chmod +x openbar.sh
   ./openbar.sh
   ```
3. **Follow the menu** to use either option.

---

### **Features**

- Menu-driven interface, simple for Termux.
- Header with “open bar” and your credit.
- Option 1: Auto-opens any URL at chosen intervals.
- Option 2: Searches RadioJavan for songs and shows top results.

---

Let me know if you need enhancements, like better music result formatting or persistent configuration!