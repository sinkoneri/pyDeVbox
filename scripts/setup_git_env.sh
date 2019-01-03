. ~/.local/bin/helper.sh

GIT_EMAIL_ADDRESS="$1"
GIT_USERNAME="$2"

ls ~/.gitconfig > /dev/null 2>&1
IS_GITCONFIG=$?
if [ $IS_GITCONFIG -gt 0 ]; then
    fprint "INFO" "SETUP GIT..."

    # Mandatory usernam and email
    git config --global user.email "${GIT_EMAIL_ADDRESS}"
    git config --global user.name "${GIT_USERNAME}"

    # Add some alias
    git config --global alias.plog "log --pretty=format:'%Cred%h%Creset %s -%C(yellow)%d%Creset %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    git config --global alias.lol "log --graph --decorate --pretty=oneline --abbrev-commit"
    git config --global alias.st "status"
    git config --global alias.ci "commit"
    git config --global alias.co "checkout"
    git config --global alias.br "branch"
    git config --global alias.di "difftool"
    git config --global alias.brco "checkout -b"

# Add git branch name in prompt
cat >> ~/.bashrc << EOF
parse_git_branch(){
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
EOF
echo 'export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ "' >> ~/.bashrc
else
    fprint "SUCCESS" "GIT ALREADY CONFIGURED..."
fi
