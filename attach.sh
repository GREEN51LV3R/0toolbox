#!/bin/bash

# Check if input file is provided
if [ $# -ne 2 ]; then
  echo "[+] Usage: $0 <input_file> <output_file>"
  exit 1
fi

input_file="$1"
output_file="$2"

# Ensure the input file exists
if [ ! -f "$input_file" ]; then
  echo "[+]Error: Input file '$input_file' not found."
  exit 1
fi

# Process each domain in the input file
while IFS= read -r domain; do
  if [[ -n "$domain" ]]; then
    echo "http://$domain" >> "$output_file"
    echo "https://$domain" >> "$output_file"
  fi
done < "$input_file"

echo "[+]Processed domains saved to '$output_file'."
