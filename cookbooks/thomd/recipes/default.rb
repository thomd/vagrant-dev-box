helper = Thomd::Helper.new('2.1.2', 'thomd')

# create a user
user helper.user do
  home helper.home
  shell '/bin/bash'
end

# copy files from within cookbooks/thomd/files/default into users home
remote_directory helper.home do
  user helper.user
  files_owner helper.user
  source 'home-thomd'
end

# copy .ssh folder from vagrant-user into users home
execute 'copy-ssh' do
  command "cd #{helper.home} ; cp -r ~vagrant/.ssh . ; chmod 700 .ssh ; chown -R #{helper.user} .ssh"
end

# create an empty .ssh/config file
file "#{helper.home('.ssh/config')}" do
  content ''
end

# configure passwordless sudo for the new user
execute 'create-sudoers-file' do
  command "cd /etc/sudoers.d/ ; cat vagrant | sed 's/vagrant/#{helper.user}/g' > #{helper.user}"
end

# install git
package 'git'

# git-clone my dotfiles from github
git(helper.home('dotfiles')) do
  repository 'http://github.com/thomd/dotfiles'
  user helper.user
  branch 'linux'
end

# install dotfiles
execute 'install dotfiles' do
  command "cd #{helper.home('dotfiles')} ; make"
end

