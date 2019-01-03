# Description
An ubuntu Vagrant box for python developement with basic tweaks.<br/>

  * virtulenvwrapper support
  * pre configured .vimrc
  * pre configured .gitconfig
  * pre configured .bashrc

Use this on a windows machine if you like to do some python develpement and testing.

# Requirements

* [Vagrant](https://www.vagrantup.com/docs/installation/)
* [Virtualbox](https://www.virtualbox.org/)

# Supported OS

* Linux
* Windows

# Features

## Vim<br/>
* Branch name in prompt with [powerline](https://github.com/Lokaltog/powerline) or without it.<br/>
* Syntax check
* automatic trailing whitespace removal at save
* templates
* etc...(see details via plugin links)

### Vim plugins: <br/>
* [Vundle](https://github.com/VundleVim/Vundle.vim) as plugin manager
* [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
* [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)  
* [vim-surround](https://github.com/tpope/vim-surround)  
* [syntastic](https://github.com/vim-syntastic/syntastic.git) 
* [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim)  
* [vim-templates](https://github.com/tibabit/vim-templates) (Added python template)

## git addons
* .gitconfig with usefull aliases<br/>
## virtualenv 
* [Virtualenv](https://virtualenv.pypa.io/en/latest/) with [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/index.html)<br/>
 (python2.7, python3.5 support)<br/>
 
## powerline
Enabled by default in:
* vim
* [bash](https://github.com/jaspernbrouwer/powerline-gitstatus)<br/>
* tmux<br/>

(Change in Vagrantfile: yes/no)<br/>

## Locale
* timezone: __Europe/Budapest__ (Change in Vagrantfile)
* locale: __hu_HU.UTF-8, en_US.UTF-8__  (Change in Vagrantfile)

## shared folders
   __/data__ (for data you like)
   <br/>
   __/Projects__ (default virtualenv Project dir)

## Portforward 
* 8000 port accessible from outside on port 8088
* Add more port(s) and don't forget to setup in Virtualbox's NAT section.

# Setup
Change your prefered values in Vagrantfile

* timezone and locale
* git username and email address
* locale_lang
* default_lang
* hostname
* vm_ram
* vm_cpu

# WINDOWS
On Windows I recommend using putty to ssh to the vagrant box.

## Powerline support in putty session

* Install fonts
Install DejaVu Sans Mono for Powerline from fonts dir by double click on it.

* Generate private key to ssh to vagrant box

1. Start Windows CMD and from the cloned repo dir, enter: 'vagrant ssh-config'

  ```
  C:\HashiCorp\machines\pydevbox>vagrant ssh-config

  Host default
  HostName 127.0.0.1
  User vagrant
  Port 2222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile C:/HashiCorp/machines/pydevbox/.vagrant/machines/default/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL
  ForwardAgent yes
  ```

2. Start puttygen

3. Load the private_key file in puttygen (from IdentityFile location, select see all file if not shown)

4. Save the private key as the Popup says. (RSA, 2048 bits by default is OK)

* Setup putty to connect to Vagrant box

1. Start putty and create a new session

  ```
  Session    > hostname: 127.0.0.1
                  port: 2222
  Window     > Appearance
                  Font change to already installed DejaVu Sans Mono for Powerline
                  enable: Clear Type
  Connection > Data
                Auto login name:
                  if host OS Windows: vagrant
                  if host OS Ubuntu: ubuntu
  Connection > SSH > Auth
                   Private key file for authentication:
                   <Browse...> load your generated private key here
  ```
2. Save session


# Usage
* clone the repo
* cd pydevbox
* start the vagrant box:
```
  $ vagrant up
```

* Wait...till boots up
* ssh to box:
```
 $ vagrant ssh (or use putty)
 ```

* Type "help_virtualenv" for quick help on creating python projects
* Type "help_tmux" for quick help on tmux
