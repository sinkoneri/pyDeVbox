# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

#-------------#
# CHANGE_HERE #
#-------------#
# Add your gitconfig username and email
# Git aliases in setup_git_env.sh, add more if you like.

# .gitconfig data
git_email = "git_email"
git_username = "git_username"

#-------------#
# CHANGE_HERE #
#-------------#
# LANG
locale_lang = "hu_HU.UTF-8"
default_lang = "en_US.UTF-8"


# Powerline support for
vim = "yes"
bash = "yes"
tmux = "yes"

# TIMEZONE
timezone = "Europe/Budapest"

VAGRANTFILE_API_VERSION = "2"
box      = 'ubuntu/xenial64'
url      = 'https://atlas.hashicorp.com/ubuntu/boxes/xenial64'
hostname = 'pydevbox'

# ip       = '192.168.56.76'  # SET FIX IP HERE
#                               UNCOMMENT LINE 73
#                               COMMENT LINE 77
vm_ram      = '4096'
vm_cpu      = '2'

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  message = "Use \"vagrant ssh\" to log into the box. This VM uses #{vm_cpu} CPUs and #{vm_ram}MB of RAM. \
  Builtin help command: \"help_tmux\" \"help_virtualenv\".
  "

  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  # Prevent TTY Errors (copied from laravel/homestead: "homestead.rb" file)... By default this is "bash -l".
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.box = box
  config.vm.box_url = url
  config.vm.host_name = hostname

  ENV['LC_ALL']="#{default_lang}"
  # FIX IP
  # config.vm.network :private_network, ip: ip

  # DHCP
  config.vm.network "private_network", type: "dhcp"

  # Port forward. Don`t forget to set also in your virtulabox`s NAT settings.
  # 8000 > 8088
  config.vm.network "forwarded_port", guest: 8000, host: 8088

  # OS check
  if Vagrant::Util::Platform.windows? then
    myHomeDir = "/home/vagrant"
  else
    myHomeDir = "/home/ubuntu"
  end

  # SHARED FOLDERS WITH RELATIVE PATH, CREATE DIR ON GUEST IF NOT EXISTS
  config.vm.synced_folder "data/", "#{myHomeDir}/data", create: true,
  mount_options: ["dmode=775,fmode=744"]
  config.vm.synced_folder "Projects/", "#{myHomeDir}/Projects", create: true,
  mount_options: ["dmode=775,fmode=744"]

  config.vm.provider "virtualbox" do |vb|

  # Customize the amount of memory on the VM:
  vb.memory = vm_ram
  vb.cpus = vm_cpu
  vb.name = hostname
  vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]

  # Forward ssh agent
  config.ssh.forward_agent = true

  #  To display the VirtualBox GUI when booting the machine
  #  set: vb.gui = true
  # NO GUI by default
  vb.gui = false
  end

  config.vm.provision "shell", inline: <<-SHELL
    # fix hosts ubuntu/xenial
    grep `hostname` /etc/hosts
    if [ $? = 1 ];then
       echo 127.0.0.1 `hostname` | sudo tee -a /etc/hosts
    fi

    # UPDATE REPO IF OLDER THAN 10 MIN
    if [ "$[$(date +%s) - $(stat -c %Z /var/lib/apt/periodic/update-success-stamp)]" -ge 600000 ]; then
      echo "apt cache older than 10 minutes"
      apt-get update
    fi

    # echo -e "\e[1;46m Forwarded Ports: \e[0m"
    echo -e "\e[1;46m \e[0m SETUP PORT FORWARD: 8000 >> 8088 "
    APPEND_MESSAGE="Open web browser on http://localhost:8088 for Web interface."
  SHELL

  # provision builtins.sh (helper functions)
  config.vm.provision "file", source: "helpers/helper.sh", destination: "~/.local/bin/helper.sh"

  # config.vm.provision "file", source: "helpers/", destination: "~/data/helpers"

  # Setup timzone
  config.vm.provision :shell, :inline => "sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/#{timezone} /etc/localtime", run: "always"

  # Install basic packages
  config.vm.provision "shell", path: "scripts/install_basic_packages.sh", args: [locale_lang, default_lang], privileged: false

  # Setup Git
  config.vm.provision "shell", path: "scripts/setup_git_env.sh", args: [git_email, git_username], privileged: false

  # Setup virtualenv
  config.vm.provision "shell", path: "scripts/setup_virtualenv.sh", privileged: false

  # Setup powerline: https://github.com/powerline/powerline
  config.vm.provision "shell", path: "scripts/setup_powerline.sh", args: [vim, bash, tmux], privileged: false

  # Setup vim
  config.vm.provision "shell", path: "scripts/setup_vim.sh", privileged: false

  # Setup oh-my-zsh: https://github.com/robbyrussell/oh-my-zsh
  # config.vm.provision "shell", path: "scripts/setup_zsh.sh", privileged: false

  config.vm.post_up_message = message
  # Keep this as last line.
end
