#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "/etc/sysconfig/iptables.sh" do
    source "iptables.sh"
    mode 700
end

bash "Apply itables" do
    user 'root'
    code <<-EOC
        /etc/sysconfig/iptables.sh
    EOC
end
