#!/bin/sh

[ -r /etc/lsb-release ] && . /etc/lsb-release
[ -r /etc/lsb-release ] && . /usr/lib/os-release

if [ -z "$DISTRIB_DESCRIPTION" ] && [ -x /usr/bin/lsb_release ]; then
	# Fall back to using the very slow lsb_release utility
	DISTRIB_DESCRIPTION=$(lsb_release -s -d)
fi

printf "Welcome to %s (%s %s %s)\n" "$DISTRIB_DESCRIPTION" "$(uname -o)" "$(uname -r)" "$(uname -m)"

printf "\n"
printf " * Documentation:  https://help.ubuntu.com\n"
printf " * Management:     https://landscape.canonical.com\n"
printf " * Support:        https://ubuntu.com/advantage\n"

  # System load:  1.0                Processes:              135
  # Usage of /:   51.9% of 49.15GB   Users logged in:        1
  # Memory usage: 28%                IP address for eth0:    10.0.0.16
  # Swap usage:   39%                IP address for docker0: 172.17.0.1