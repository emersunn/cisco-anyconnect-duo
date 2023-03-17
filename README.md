# cisco-anyconnect-duo.sh
script to connect to vpn with anyconnect and duo

Created to login to a VPN using Cisco AnyConnect without typing in your password into the app each time. Made for Mac, it uses the anyconnect cli and the apple keychain. Duo will send you a push, sms, or call you for 2FA. This of course assumes your VPN uses Duo to authenticate.

When you run this script, do not type in your password wrong. If you do it will fail and you will have to delete the password from the keychain.

Run it in terminal first. After that you can run this script from apple shortcuts, automator, or keyboard maestro for easy access.
