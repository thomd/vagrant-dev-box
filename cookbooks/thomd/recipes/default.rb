helper = Thomd::Helper.new('2.1.2', 'thomd')

user helper.user do
  home helper.home
  shell '/bin/bash'
end

remote_directory helper.home do
  user helper.user
  files_owner helper.user
  source 'home-thomd'
end

execute 'copy-ssh' do
  command "cd #{helper.home} ; cp -r ~vagrant/.ssh . ; chmod 700 .ssh ; chown -R #{helper.user} .ssh"
end

file "#{helper.home('.ssh/config')}" do
  content ''
end

package 'git'

git(helper.home('dotfiles')) do
  repository 'http://github.com/thomd/dotfiles'
  user helper.user
  branch 'linux'
end

execute 'install dotfiles' do
  command "cd #{helper.home('dotfiles')} ; make"
end

