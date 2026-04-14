#!/bin/bash

# Increase RAM by using virtual memory from hard disk.
# Swap File


sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
free -h