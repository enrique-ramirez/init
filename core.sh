source vars.sh

echo "\n--------------------------------"
echo "\n${YELLOW}Software installs!${NC}\n"

# Install ohmyzsh
echo "\n- ${CYAN}ohmyzsh${NC}"
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "  ${GREEN}Already installed!${NC}"
else
  echo "  ${YELLOW}Installing ohmyzsh...${NC}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install NVM
echo "\n- ${CYAN}NVM${NC}"
if [ -d "${HOME}/.nvm/.git" ]; then
    echo "  ${GREEN}Already installed!${NC}"
else
    echo "  ${YELLOW}Installing NVM...${NC}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

# Install pnp
echo "\n- ${CYAN}pnpm${NC}"
if command -v pnpm &> /dev/null; then
    echo "  ${GREEN}Already installed!${NC}"
else
    echo "  ${YELLOW}Installing pnpm...${NC}"
    curl -fsSL https://get.pnpm.io/install.sh | sh -
fi

# Installing homebrew
echo "\n- ${CYAN}homebrew${NC}"
if command -v brew &> /dev/null; then
    echo "  ${GREEN}Already installed!${NC}"
else
    echo "  ${YELLOW}Installing homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Installing bat
echo "\n- ${CYAN}bat${NC}"
if command -v bat &> /dev/null; then
    echo "  ${GREEN}Already installed!${NC}"
else
  # Installing bat
  echo "  ${YELLOW}Installing bat through homebrew...${NC}"
  brew install bat
fi

# Installing fzf
echo "\n- ${CYAN}fzf${NC}"
if command -v fzf &> /dev/null; then
    echo "  ${GREEN}Already installed!${NC}"
else
  # Installing fzf
  echo "  ${YELLOW}Installing fzf through homebrew...${NC}"
  brew install fzf
fi

FZF_SOURCE_LINE="source <(fzf --zsh)"
if ! grep -qxF "$FZF_SOURCE_LINE" "$ZSHRC_FILE"; then
  # If the line does not exist, append it
  echo "  $FZF_SOURCE_LINE" >> "$ZSHRC_FILE"
  echo "  Added the setup line for ${GREEN}fzf${NC} to $ZSHRC_FILE"
else
  echo "  The setup line for ${GREEN}fzf${NC} already exists in ${CYAN}$ZSHRC_FILE${NC}"
fi

# Installing diff-so-fancy
echo "\n- ${CYAN}diff-so-fancy${NC}"
if command -v diff-so-fancy &> /dev/null; then
    echo "  ${GREEN}Already installed!${NC}"
else
  # Installing diff-so-fancy
  echo "  ${YELLOW}Installing diff-so-fancy through homebrew...${NC}"
  brew install diff-so-fancy
  echo "  Configuring git to use diff-so-fancy..."
  git config --global core.pager "diff-so-fancy | less --tabs=4 -RF"
  git config --global interactive.diffFilter "diff-so-fancy --patch"
fi

echo "\n${YELLOW}Sourcing .zshrc...${NC}"
source ~/.zshrc

echo "\n${CYAN}git${NC}"
if [ -d "$HOME/Projects" ]; then
  echo "  ${GREEN}Git folder already exists!${NC}"
else
  echo "  ${YELLOW}Creating ~/Projects folder...${NC}"
  mkdir -p "$HOME/Projects"
fi

echo "  \n${YELLOW}Configuring git...${NC}"
git config --global user.name "Enrique Ramírez"
git config --global user.email "hello@enriqueramirez.com"
git config --global core.editor "cursor --wait"
git config --global alias.co "checkout"
git config --global alias.br "branch"
git config --global alias.cm "commit"
git config --global alias.st "status"
git config --global alias.df "diff"
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global alias.ll "log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

echo "\n${GREEN}Software installs done!${NC}\n"

echo "--------------------------------\n"

echo "${YELLOW}Do you want to update OSX software now?:${NC}"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) break;;
    No ) exit;;
  esac
done

# Continue if user wants to update OSX software
echo "\n${CYAN}Updating OSX software...${NC}"
softwareupdate -i -a
