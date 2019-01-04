source ~/.local/bin/helper.sh


vim_support=${1:=yes}
bash_support=${2:=yes}
tmux_support=${3:=yes}


vim_support()
{
# Vim statusline
cat >> ~/.vimrc << EOF
" Powerline python 2.7
set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim/
" Powerline python 3.5
set rtp+=~/.local/lib/python3.5/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
EOF
}

bash_support()
{
# powerline-gitstatus shell:  https://github.com/jaspernbrouwer/powerline-gitstatus
pip install --user powerline-gitstatus
# save original color scheme
cp ~/.local/lib/python2.7/site-packages/powerline/config_files/colorschemes/shell/default.json ~/.local/lib/python2.7/site-packages/powerline/config_files/colorschemes/shell/default.json.orig
# deploy new color scheme
cp /vagrant/helpers/powerline_gitstatus_colorscheme.json ~/.local/lib/python2.7/site-packages/powerline/config_files/colorschemes/shell/default.json
# save original settings
cp ~/.local/lib/python2.7/site-packages/powerline/config_files/themes/shell/default.json ~/.local/lib/python2.7/site-packages/powerline/config_files/themes/shell/default.json.orig
# deploy new settings
cp /vagrant/helpers/powerline_shell_default.json ~/.local/lib/python2.7/site-packages/powerline/config_files/themes/shell/default.json

cat >> ~/.bashrc << EOF
# Powerline in bash
if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
  source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi
EOF
}


tmux_support()
{
cat >> ~/.tmux.conf << EOF
source ~/.local/lib/python2.7/site-packages/powerline/bindings/tmux/powerline.conf
set-option -g default-terminal "screen-256color"
EOF
}


####  MAIN  ###

grep -q builtins ~/.bashrc
IS_HELPER_INSTALLED=$?
if [[ $IS_HELPER_INSTALLED -gt 0 ]];then
cat >> ~/.bashrc << EOF
source ~/.local/bin/helper.sh
EOF
fi


# Configuring powerline
pip list | grep powerline > /dev/null 2>&1
IS_POWERLINE_INSTALLED=$?


if [ $IS_POWERLINE_INSTALLED -gt 0 ];then
    fprint "INFO" "INSTALL POWERLINE..."
    # Requirements
    sudo apt-get install -qq fontconfig
    # Install powerline in userspace
    pip install --user git+git://github.com/Lokaltog/powerline
    # Install fonts
    wget --quiet https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
    fc-cache -vf ~/.fonts
    mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

cat >> ~/.bashrc << EOF
if [ -d "\$HOME/.local/bin" ]; then
  PATH="\$HOME/.local/bin:\$PATH"
fi
EOF

    if [ "x${vim_support}" == "xyes" ];then
        vim_support
    fi

    if [ "x${bash_support}" == "xyes" ];then
        bash_support
    fi

    if [ "x${tmux_support}" == "xyes" ];then
        tmux_support
    fi
else
  fprint "SUCCESS" "POWERLINE ALREADY INSTALLED..."
fi
