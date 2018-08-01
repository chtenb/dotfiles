nmap -sL "$1" | grep "Nmap scan report" | awk '{print $NF}'
