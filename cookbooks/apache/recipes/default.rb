#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2015, Kartik Null Cating-Subramanian
#
# All rights reserved - Do Not Redistribute
#

package 'httpd' do
	action :install
end

execute 'disable welcome' do
	command 'mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.disabled'
	only_if { File.exists?('/etc/httpd/conf.d/welcome.conf') }
	notifies :restart, 'service[httpd]'
	action :run
end

node['apache']['sites'].each do |site_name, site_data|
	document_root = "/srv/apache/#{site_name}"

	template "/etc/httpd/conf.d/#{site_name}.conf" do
		source 'custom.erb'
		mode '0644'
		variables(
			:document_root => document_root,
			:port => site_data['port']
		)
		notifies :restart, 'service[httpd]'
		action :create
	end

	directory document_root do
		mode '0755'
		recursive true
	end

	template "#{document_root}/index.html" do
		source 'index.html.erb'
		mode '0644'
		variables(
			:site_name => site_name,
			:port => site_data['port']
		)
		action :create
	end
end

service 'httpd' do
	action [:enable, :start]
end
