#!/bin/bash

# Connect to VPN using Cisco AnyConnect, MacOS Keychain, and the Duo authentication method AKA "second password"

# Variables
VPN_HOST="foo.bar"         # Replace with your VPN server's hostname or IP address
VPN_USER="foobar"          # Replace with your VPN username
VPN_PASSWORD=""            # Leave blank to use keychain password
DUO_FACTOR="push"          # Can be "push", "phone" or "sms"
KEYCHAIN_ITEM="AnyConnect-${VPN_HOST}" # Can be any name you prefer this example creates a keychain item called "AnyConnect-foo.bar"
 
# Get VPN password from keychain, if not available add VPN password to keychain
# Type in password carefully! 
# If it's wrong you won't get a chance to try again
# If you put in the wrong password, delete it in Keychain and run the script again
if [ -z "${VPN_PASSWORD}" ]; then
  VPN_PASSWORD=$(security find-generic-password -a "${VPN_USER}" -s "${KEYCHAIN_ITEM}" -w 2>/dev/null)
  if [ -z "${VPN_PASSWORD}" ]; then
    echo "VPN password not found in keychain. Please enter your VPN password:"
    read -s VPN_PASSWORD
    security add-generic-password -a "${VPN_USER}" -s "${KEYCHAIN_ITEM}" -w "${VPN_PASSWORD}"
  fi
fi

# Make temp file for anyconnect to read from — with user, password, and duo method
TMPFILE=$(mktemp creds.XXXXXX)
>> $TMPFILE
echo ${VPN_USER} > $TMPFILE
echo ${VPN_PASSWORD} >> $TMPFILE
echo ${DUO_FACTOR} >> $TMPFILE

# Connect to VPN and read credentials from temp file
echo "Connecting to VPN..."
/opt/cisco/anyconnect/bin/vpn -s < "$TMPFILE" connect ${VPN_HOST}

# Delete temp file
rm $TMPFILE

# You might want to make a seperate disconnect script, put this in a new file
# echo "Disconnecting…"
# /opt/cisco/anyconnect/bin/vpn disconnect
