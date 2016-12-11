ENV['LANG'] = 'en_US.UTF-8'
ENV['LANGUAGE'] = ENV['LANG']
ENV['LC_ALL'] = ENV['LANG']

file "#{ENV['HOME']}/test.txt" do
  content 'This file was created by Chef!'
end

include_recipe 'chrome::default'

remote_file '/tmp/atom.deb' do 
	source "https://github.com/atom/atom/releases/download/v1.12.7/atom-amd64.deb"
	mode '755'
	action :create_if_missing
	notifies :action, 'package[gvfs-bin]', :immediate
end

package 'gvfs-bin' do 
	action :install
	notifies :action, 'dpkg_package[atom]', :immediate
end

dpkg_package 'atom' do
	source '/tmp/atom.deb'
	provider Chef::Provider::Package::Dpkg
end


