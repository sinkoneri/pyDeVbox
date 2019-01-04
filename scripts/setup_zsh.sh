. ~/.local/bin/helper.sh

# Configuring zsh1
zsh --version  > /dev/null 2>&1
ZSH_IS_INSTALLED=$?
if [ $ZSH_IS_INSTALLED -gt 0 ];then
    fprint "INFO" "INSTALL OH-MY-ZSH..."
    # install requirements
    sudo apt-get install -qq zsh
    # clone repo
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    # create default config
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    # change default shell to zsh
    sudo chsh -s /bin/zsh
    # change theme
    sed -i -e "s/robbyrussell/agnoster/" ~/.zshrc
else
    fprint "SUCCESS" "OH-MY-ZSH ALREADY INSTALLED..."
fi
