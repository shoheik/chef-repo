#
# Cookbook Name:: yum_update
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "yumupdate" do
  user "root"
  command "yum -y update"
  action :run
end
