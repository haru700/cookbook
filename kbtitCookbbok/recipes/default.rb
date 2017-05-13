#
# Cookbook Name:: kbtitCookbbok
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
pakage "httpd"

template "/etc/httpd/conf.d/#{ENV['HOSTNAME']}.conf" do
  source "virtualhost.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables({
    :env_hostname => "#{ENV['HOSTNAME']}",
  })
end

directory "#{node[:apache][:documentroot]/ENV['HOSTNAME']}" do
  action :create
end

git "/var/www/#{ENV['HOSTNAME']}" do
  repository "https://github.om/haru700/chefKbtit.git"
  reference "master"
  action :sync
end

service "httpd" do
  action :start
end
