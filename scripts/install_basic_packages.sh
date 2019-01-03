LOCALE_LANG=${1:=hu_HU.UTF-8}           # hu_HU.UTF-8 if not set or empty
DEFAULT_LANG=${2:=en_US.UTF-8}          # en_US.UTF-8 if not set or empty

# Configure timezone and locale
set_locale()
{
    sudo locale-gen "${LOCALE_LANG}"
    sudo update-locale LANG="${DEFAULT_LANG}"
}

echo -e "\e[1;46m \e[0m INSTALLING BASIC PACKAGES..."
sudo apt-get install -qq mc shellcheck pylint tmux git python-pip python3-pip dos2unix zip

if [ $? -eq 0 ]; then
    echo -e "\e[1;42m \e[0m SUCCESS"
    set_locale
else
    echo -e "\e[1;41m \e[0m FAIL"
fi
