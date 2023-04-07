# Cisco Anyconnect with Duo

This script automates the process of connecting to a VPN using Cisco AnyConnect on macOS, with MacOS Keychain for password storage and Duo authentication for second-factor authentication.

## Features

- Automatically retrieves VPN password from the macOS Keychain
- If the password is not found in the Keychain, prompts for input and stores it securely
- Supports three Duo authentication methods: push, phone, and SMS
- Temporarily stores credentials in a secure file for the duration of the connection process
- Automatically removes the temporary credentials file after use

## Requirements

- Cisco AnyConnect client installed on macOS
- Duo authentication set up for the VPN

## Usage

1. Open the script with a text editor and replace the following variables:

  - VPN_HOST: Replace with your VPN server's hostname or IP address
  - VPN_USER: Replace with your VPN username
  - VPN_PASSWORD: Leave blank to use the Keychain password
  - DUO_FACTOR: Can be "push", "phone" or "sms"
  - KEYCHAIN_ITEM: Can be any name you prefer, this example creates a Keychain item called "AnyConnect-foo.bar"

2. Save the script, and then run it in a terminal window. The script will either connect to the VPN using the stored Keychain password or prompt for input if the password is not found.

If you wish to create a separate script for disconnecting from the VPN, create a new file with the following content:

```
echo "Disconnecting…"
/opt/cisco/anyconnect/bin/vpn disconnect
```
