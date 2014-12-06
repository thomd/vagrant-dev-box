user 'thomd' do
  home '/home/thomd'
  shell '/bin/bash'
end

remote_directory '/home/thomd' do
  user 'thomd'
  files_owner 'thomd'
  source 'home-thomd'
end

execute 'copy-ssh' do
  command "cd i~web ; cp ~/vagrant/.ssh . ; chmod 700 .ssh ; chown -R web .ssh"
end
