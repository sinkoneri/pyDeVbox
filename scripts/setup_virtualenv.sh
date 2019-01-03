. ~/.local/bin/helper.sh

# Configuring virtualenv
virtualenv --version  > /dev/null 2>&1
VIRTUALENV_IS_INSTALLED=$?

if [ $VIRTUALENV_IS_INSTALLED -gt 0 ];then
    fprint "INFO" "INSTALL VIRTUALENVWRAPPER..."
    sudo apt-get install -qq virtualenvwrapper
    fprint "INFO" "CONFIGURING VIRTUALENVWRAPPER..."
    cd ~
    mkdir -p .virtualenvs && mkdir -p Projects
    chown -R "$USER:$USER" ~/.virtualenvs ~/Projects
    echo "export WORKON_HOME=~/.virtualenvs" >> ~/.bashrc
    echo "export PROJECT_HOME=~/Projects" >> ~/.bashrc
    echo "source /usr/share/virtualenvwrapper/virtualenvwrapper.sh" >> ~/.bashrc
    echo "VIRTUALENVWRAPPER_WORKON_CD=0" >> ~/.virtualenvs/postmkproject
else
    fprint "SUCCESS" "VIRTUALENV ALREADY INSTALLED..."
fi
