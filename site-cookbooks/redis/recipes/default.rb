# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "redis" do
    action :install
end

service "redis" do
  action :nothing
  action [ :enable, :start ]
  supports :status => true, :start => true, :stop => true, :restart => true
end


