#!/bin/bash

usage() {
  echo "[+] Usage: $0 <add|remove> <input_file> <output_file>"
  echo
  echo "[+] Options:"
  echo "  add      - Add http:// and https:// to each domain."
  echo "  remove   - Remove http:// and https:// from each domain."
  exit 1
}

# Check if sufficient arguments are provided
if [ $# -ne 3 ]; then
  usage
fi

action="$1"
input_file="$2"
output_file="$3"


if [ ! -f "$input_file" ]; then
  echo "[-] Error: Input file '$input_file' not found."
  exit 1
fi

# Create or clear the output file
> "$output_file"


case "$action" in
  add)
    echo "[+] Adding http:// and https:// to domains..."
    while IFS= read -r domain; do
      if [[ -n "$domain" ]]; then
        echo "http://$domain" >> "$output_file"
        echo "https://$domain" >> "$output_file"
      fi
    done < "$input_file"
    echo "[+] Processed domains saved to '$output_file'."
    ;;
  remove)
    echo "[+] Removing http:// and https:// from domains..."
    while IFS= read -r domain; do
      if [[ -n "$domain" ]]; then
        
        clean_domain="${domain#http://}"
        clean_domain="${clean_domain#https://}"
        echo "$clean_domain" >> "$output_file"
      fi
    done < "$input_file"
    echo "[+] Processed domains saved to '$output_file'."
    ;;
  *)
    echo "[+] Error: Invalid action '$action'."
    usage
    ;;
esac
