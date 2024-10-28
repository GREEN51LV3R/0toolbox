#!/bin/bash

echo "Updating System"
sudo nala update && sudo nala upgrade -y # if you are using nala.
# sudo apt-get update && sudo apt-get upgrade -y

echo "Cleaning up"
sudo apt-get autoremove -y && sudo apt-get clean
echo "System updated and cleaned"



