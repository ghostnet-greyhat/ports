#!/bin/bash

# Define array of common ports to scan
ports=(21 22 23 25 53 80 110 135 137 138 139 143 389 443 445 465 587 993 995 1433 1521 3306 3389 5432 8080 8443)

# Function to check service version
function check_version {
  echo -e "Trying to connect to $1:$2...\n" 
  response=$(echo "QUIT" | timeout 5s telnet $1 $2 2>&1)
  if [[ "$response" =~ "Escape character is" ]]; then
    version=$(echo "$response" | grep -oP "Escape character is '(.*)'" | cut -d"'" -f2)
    echo "Service running on $1:$2 is $3, version: $version"
  else
    echo "Cannot connect to $1:$2, service might not be running or is not accessible"
  fi
}

# Loop through each port and check if the service is accessible
for port in ${ports[@]}; do
  case $port in
    21)   check_version $1 $port "FTP"
          ;;
    22)   check_version $1 $port "SSH"
          ;;
    23)   check_version $1 $port "Telnet"
          ;;
    25)   check_version $1 $port "SMTP"
          ;;
    53)   check_version $1 $port "DNS"
          ;;
    80)   check_version $1 $port "HTTP"
          ;;
    110)  check_version $1 $port "POP3"
          ;;
    135)  check_version $1 $port "RPC"
          ;;
    137)  check_version $1 $port "NetBIOS"
          ;;
    138)  check_version $1 $port "NetBIOS"
          ;;
    139)  check_version $1 $port "SMB"
          ;;
    143)  check_version $1 $port "IMAP"
          ;;
    389)  check_version $1 $port "LDAP"
          ;;
    443)  check_version $1 $port "HTTPS"
          ;;
    445)  check_version $1 $port "SMB"
          ;;
    465)  check_version $1 $port "SMTPS"
          ;;
    587)  check_version $1 $port "SMTP"
          ;;
    993)  check_version $1 $port "IMAPS"
          ;;
    995)  check_version $1 $port "POP3S"
          ;;
    1433) check_version $1 $port "SQL Server"
          ;;
    1521) check_version $1 $port "Oracle"
          ;;
    3306) check_version $1 $port "MySQL"
          ;;
    3389) check_version $1 $port "RDP"
          ;;
    5432) check_version $1 $port "PostgreSQL"
          ;;
    8080) check_version $1 $port "HTTP Proxy"
          ;;
    8443) check_version $1 $port "HTTPS"
          ;;
    *)    check_version $1 $port "Unknown"
          ;;
  esac
done
