#
# Cookbook Name:: motd
# Recipe:: default
#
# Copyright 2015, Chef
#
# All rights reserved - Do Not Redistribute
#

template "/etc/motd" do
	action :create
	source "motd.erb"
	mode "0644"
end
