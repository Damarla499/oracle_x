#
# Cookbook:: oracle_client
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

group 'dba' do
  action :create
  gid '501'
end

user 'oracle' do
  comment 'Oracle User'
  uid '500'
  gid '501'
end

directory '/opt/app' do
  owner 'oracle'
  group 'dba'
  action :create
end

yum_package 'ksh' do
  action :install
end

yum_package 'libaio-devel' do
  action :install
end

remote_file '/home/oracle/oracle_x64_12201_client.zip' do
  source 'http://deploymentrepo.apollogrp.edu/packages/oracle_x64_12201_client.zip'
  owner 'oracle'
  group 'dba'
  mode '0775'
  action :create
end

execute 'unzip_oracle_client' do
  command 'tar -xvzf oracle_x64_12201_client.zip'
  cwd '/home/oracle'
  #not_if { File.exists?("") }
end

cookbook_file '/home/oracle/client.rsp' do
  source 'client.rsp'
  owner 'oracle'
  group 'dba'
  action :create
end

execute 'install_oracle_client' do
  command '/home/oracle/client/runInstaller -silent -responseFile /home/oracle/client.rsp -ignoreSysPrereqs'
  #not_if { }
end


