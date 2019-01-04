. ~/.local/bin/helper.sh

ls "/$HOME/.vim/" > /dev/null 2>&1
IS_VIMRC=$?

install_vundle()
{
    # clone the vundle repo
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    # Add some usefull plugins
    # To install type ":InstallPlugins"

cat >> ~/.vim/plugins.vim << EOF
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" To install plugin type ":InstallPlugins"
" START ADDING PLUGINS FROM HERE

Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'vim-syntastic/syntastic.git'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tibabit/vim-templates'

" PLUGIN LIST END
call vundle#end()

filetype plugin indent on
EOF

# Insert Plugin configs to .vimrc
cat >> ~/.vimrc << EOF
" SYNTASTIC DEFAULT SETTINGS
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" file change track update time in ms"
set updatetime=100

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" GITGUTTER SETTINGS
" uncomment this if needed / gitgutter signes not shown
" let g:gitgutter_terminal_reports_focus=0

" vim-gitgutter will suppress the signs when a file has more than 500
let g:gitgutter_max_signs = 500

" file change track update time in ms"
set updatetime=100

" SOURCE PLUGINS CONFIG
source ~/.vim/plugins.vim
EOF

# Editor config plugin settings
cat >> ~/.editorconfig << EOF
root = true
[*]
charset = utf-8
indent_style = space
indent_size = 4
trim_trailing_whitespace = true
insert_final_newline = true
[*.md]
trim_trailing_whitespace = false
EOF
}


#### MAIN


if [ $IS_VIMRC != 0 ];then
    fprint "INFO" "SETUP VIMRC..."
cat >>"$HOME/.vimrc" <<EOL
" colorscheme
syntax on
colorscheme elflord

" 4 spaces indentation, no tabs
set tabstop=4
set shiftwidth=4
set expandtab

" remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

" Color trailing whitespace and tabs
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$\|\t/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$\|\t/
au InsertLeave * match ExtraWhiteSpace /\s\+$\|\t/
" GENERAL SETTINGS END
EOL
# Install Vundle as vim plugin manager
install_vundle
# Download Plugins

vim -c 'PluginInstall' -c 'qa!'
cp /vagrant/helpers/py.template ~/.vim/bundle/vim-templates/templates/
else
    fprint "SUCCESS" "VIMRC ALREADY CONFIGURED..."
fi
