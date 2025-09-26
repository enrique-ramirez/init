source vars.sh

SSH_CONFIG_FILE_CONTENTS="
Host github.com
  HostName github.com
  User git
  IdentityFile ${SSH_ID_FILE_PATH}
"
echo "\n${YELLOW}Generating SSH key...${NC}"
# ssh-keygen -t rsa -b 4096 -C "hello@enrique-ramirez.com"
# eval "$(ssh-agent -s)"

# Create ${HOME}/.ssh/config file if it doesn't exist
if [ -e "$SSH_CONFIG_FILE" ]; then
  echo "${CYAN}$SSH_CONFIG_FILE${NC} exists."
else
  echo "${CYAN}$SSH_CONFIG_FILE${NC} does not exist, creating it..."
  touch ${HOME}/.ssh/config
fi

# TODO: Paste SSH_CONFIG_FILE_CONTENTS into ${HOME}/.ssh/config SAFELY
# ssh-add --apple-use-keychain $SSH_ID_FILE_PATH

pbcopy < ${SSH_ID_FILE_PATH}.pub
echo "\n${GREEN}$SSH_ID_FILE_PATH.pub file copied to clipboard! Paste it into your GitHub account!${NC}"
