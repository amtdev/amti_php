#
# Cookbook:: amti_php
# Recipe:: default
#
# Copyright:: 2018, Advanced Marketing Training, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

template '/etc/php5/apache2/php.ini' do
  source 'php.ini.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables(
    :memory_limit        	 => node['amti_php']['memory_limit'],
    :post_max_size        	 => node['amti_php']['post_max_size'],
    :upload_max_filesize     => node['amti_php']['upload_max_filesize'],
    :max_execution_time      => node['amti_php']['max_execution_time'],
    :max_input_time        	 => node['amti_php']['max_input_time'],
    :max_input_vars        	 => node['amti_php']['max_input_vars'],
    :curl_cainfo			 => node['amti_php']['curl_cainfo'])
end

template '/etc/php5/mods-available/xdebug.ini' do
  source 'xdebug.ini.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables(:zend_extension => node['amti_php']['xdebug']['zend_extension'],
            :idekey => node['amti_php']['xdebug']['idekey'],
            :remote_host => node['amti_php']['xdebug']['remote_host'],
            :remote_port => node['amti_php']['xdebug']['remote_port'])
end

service "apache2" do
  action :restart
end