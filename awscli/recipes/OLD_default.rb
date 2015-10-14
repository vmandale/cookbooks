#
# Cookbook Name:: awscli
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'python-pip' do
	action :install
end

execute 'pip install awscli' do
	command 'pip install awscli'
end

directory '/root/.aws' do
	action :create
	mode '0755'
	owner 'root'
	group 'root'
end

template '/root/.aws/config' do
	source 'aws_config.erb'
	mode '0400'
	owner 'root'
	group 'root'
end

template '/root/.aws/credentials' do
	source 'aws_credentials.erb'
	mode '0400'
	owner 'root'
	group 'root'
end
