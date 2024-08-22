# How to automatically ssh-add a password protected keyfile on KDE startup

To automatically add a password-protected SSH keyfile on KDE startup, you can utilize KWallet and systemd to streamline the process. Here’s a step-by-step guide:

### Prerequisites

Ensure you have the necessary packages installed:

```bash
sudo pacman -Syu --needed kwallet ksshaskpass kwalletmanager
```

### Step 1: Configure KWallet

1. **Install KWallet PAM**: Make sure the `kwallet-pam` and `signon-kwallet-extension` packages are installed to enable KWallet to unlock at login.

### Step 2: Set Up SSH Agent

2. **Create a systemd service for the SSH agent**:
   - Create the directory if it doesn’t exist:

     ```bash
     mkdir -p ~/.config/systemd/user
     ```

   - Create the service file:

     ```bash
     nano ~/.config/systemd/user/ssh-agent.service
     ```

   - Add the following content:

     ```
     [Unit]
     Description=SSH agent (ssh-agent)

     [Service]
     Type=simple
     Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
     ExecStart=ssh-agent -D -a $SSH_AUTH_SOCK
     ExecStop=kill -15 $MAINPID

     [Install]
     WantedBy=default.target
     ```

3. **Reload and enable the service**:

   ```bash
   systemctl --user daemon-reload
   systemctl --user enable ssh-agent.service
   ```

### Step 3: Create SSH Add Script

4. **Create a script to add your SSH keys**:
   - Create a new desktop entry in the autostart directory:

     ```bash
     nano ~/.config/autostart/ssh-add.desktop
     ```

   - Add the following content, replacing `~/.ssh/key1`, etc., with your actual key paths:

     ```
     [Desktop Entry]
     Exec=ssh-add -q ~/.ssh/key1 ~/.ssh/key2 ~/.ssh/key3 < /dev/null
     Name=ssh-add
     Type=Application
     ```

### Step 4: Configure SSH Askpass

5. **Set the SSH_ASKPASS environment variable**:
   - Create a shell script:

     ```bash
     sudo nano /etc/profile.d/ssh-askpass.sh
     ```

   - Add the following line:

     ```bash
     export SSH_ASKPASS=/usr/bin/ksshaskpass
     ```

6. **Edit your shell configuration** (e.g., `~/.bashrc` or `~/.zshenv`):

   ```bash
   nano ~/.bashrc
   ```

   - Add the following lines to ensure the SSH agent starts and your keys are added:

     ```bash
     eval $(ssh-agent -s)
     ssh-add -l &>/dev/null
     if [ "$?" != 0 ]; then
         ssh-add ~/.ssh/your_key
     fi
     ```

### Step 5: Reboot and Test

7. **Reboot your system**:

   ```bash
   sudo systemctl reboot
   ```

After rebooting, your SSH keys should be automatically added to the SSH agent without prompting for the passphrase, provided that the passphrases are stored in KWallet. You can verify this by running `ssh-add -l` in your terminal after logging in. If you encounter any prompts, ensure that your keys are correctly configured in KWallet[1][3].

Citations:
[1] https://forum.manjaro.org/t/howto-use-kwallet-as-a-login-keychain-for-storing-ssh-key-passphrases-on-kde/7088
[2] https://github.com/Sequel-Ace/Sequel-Ace/issues/299
[3] https://discuss.kde.org/t/using-kwallet-to-add-ssh-keys-upon-launch-of-the-terminal/14386
[4] https://stackoverflow.com/questions/3466626/how-to-permanently-add-a-private-key-with-ssh-add-on-ubuntu/51269134
