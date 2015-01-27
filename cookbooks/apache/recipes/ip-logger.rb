#
# Cookbook Name:: apache
# Recipe:: ip-logger
#
# Copyright 2015, Kartik Null Cating-Subramanian
#
# All rights reserved - Do Not Redistribute
#

search('node', 'platform:centos').each do |server|
	log "The CentOS servers in your organization have the following FQDN/IP addresses:- #{server["fqdn"]}/#{server["ipaddress"]}"
end
