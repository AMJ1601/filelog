#!/bin/bash

# Verify root and path
if [ "$UID" != 0 ] || [ "$#" -ne 1 ] || [[ ! "$1" =~ ^/ ]]; then
	echo -e "[!] Invalid permission or inavlid path"
	echo -e "[!] Only absolute paths"
	exit 1
fi

# Install 7zip
if ! tar --help &>/dev/null; then
	echo -e "[!] For this script I need tar, do you want install? [Y/n]"
	read install
	if [ -z $install ] || [[ $install =~ ^[Yy] ]]; then
		apt install tar -y &>/dev/null || dnf install tar -y &>/dev/null
	else
		echo -e "[!] exit..."
		exit 0
	fi
fi

mkdir -p ~/bck_log
tar -czf "$HOME/bck_log/logs_archive_$(date +%Y%m%d_%H%M%S).tar.gz" $1
