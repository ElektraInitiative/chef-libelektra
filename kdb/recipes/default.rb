#
# Cookbook:: kdb
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
#

kdbmount 'system/hosts' do
  file '/etc/hosts'
  plugins 'hosts'
  action :create
end

kdbset '/hosts/ipv4/showthatitworks' do
  namespace 'system'
  value '127.0.0.33'
  action :create
end

#kdbset 'system/hosts/ipv4/showthatitworks' do
#  action :delete
#end

kdbmount 'system/hosts' do
  action :delete
end





