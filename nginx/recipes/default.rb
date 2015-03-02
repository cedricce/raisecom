#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'nginx16' do
  action :install
end

remote_file '/usr/share/nginx/html/index.html' do
  source "https://github.com/CouponTrade/ops_interview/blob/master/index.html"
  owner 'root'
  group 'root'
  mode "0644"
end

remote_file '/usr/share/nginx/html/index.php' do
  source "https://github.com/CouponTrade/ops_interview/blob/master/index.php"
  owner 'root'
  group 'root'
  mode "0644"
end

bash 'change_port' do
  user 'root'
  cwd '/etc/nginx'
  code <<-EOH
  sed -ri 's/(^ {8}listen *)(80;)/\\180\\2/' nginx.conf
  EOH
end
  
service 'nginx' do
  action [ :enable, :start ]
end
