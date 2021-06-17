#!/bin/bash

USERNAME=${1:-codespace}
SECURE_PATH_BASE=${2:-$PATH}

echo "Defaults secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin:${SECURE_PATH_BASE}\"" >> /etc/sudoers.d/securepath

# Add user to a Docker group
sudo -u ${USERNAME} mkdir /home/${USERNAME}/.vsonline
groupadd -g 800 docker
usermod -a -G docker ${USERNAME}

# Set VS Code as user's git edtior
tee /tmp/scripts/git-ed.sh > /dev/null << EOF
#!/usr/bin/env bash

if [[ \$(which code-insiders) && ! \$(which code) ]]; then
  GIT_ED="code-insiders"
else
  GIT_ED="code"
fi

\$GIT_ED --wait \$@
EOF

sudo -u ${USERNAME} mkdir -p /home/${USERNAME}/.local/bin
install -o ${USERNAME} -g ${USERNAME} -m 755 /tmp/scripts/git-ed.sh /home/${USERNAME}/.local/bin/git-ed.sh
sudo -u ${USERNAME} git config --global core.editor "/home/${USERNAME}/.local/bin/git-ed.sh"
rm -f /tmp/scripts/git-ed.sh
