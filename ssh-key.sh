SSH_CONFIG_FILE="${HOME}/.ssh/config"
SSH_ID_FILE_PATH="${HOME}/.ssh/id_ed25519"
SSH_CONFIG_FILE_CONTENTS="
Host github.com
  HostName github.com
  User git
  IdentityFile ${SSH_ID_FILE_PATH}
"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m'

echo "\n${YELLOW}Generating SSH key...${NC}"
# ssh-keygen -t rsa -b 4096 -C "hello@enrique-ramirez.com"
# eval "$(ssh-agent -s)"

# Create ${HOME}/.ssh/config file if it doesn't exist
if [ -e "$SSH_CONFIG_FILE" ]; then
  echo "${CYAN}$SSH_CONFIG_FILE${NC} exists."
else
  echo "${CYAN}$SSH_CONFIG_FILE${NC} does not exist."
  touch ${HOME}/.ssh/config
fi

# TODO: Paste SSH_CONFIG_FILE_CONTENTS into ${HOME}/.ssh/config SAFELY
ssh-add --apple-use-keychain $SSH_ID_FILE_PATH

pbcopy < ${SSH_ID_FILE_PATH}.pub
