#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "apache2" do
  action :install
end

package "php5" do
  action :install
end

package "php5-mysql" do
  action :install
end

group "wordpress" do
  action :create
end

user "wordpress" do
  action :create
  gid "wordpress"
  system true
end

bash "install_mysql_server" do
  user "root"
  ignore_failure true
  code <<-EOH
   (echo "mysql-server-5.5 mysql-server/root_password password wordpress" | debconf-set-selections && echo "mysql-server-5.5 mysql-server/root_password_again password wordpress" | debconf-set-selections && apt-get -y --force-yes install mysql-server-5.5)
  EOH
end

bash "download_install_wordpress" do
  user "root"
  ignore_failure true
  code <<-EOH
  (wget http://wordpress.org/latest.tar.gz && tar -zxvf latest.tar.gz -C /var/www/)
   EOH
end


bash "create_database" do
  user "root"
  ignore_failure true
  code <<-EOH
    mysql -uroot -pwordpress -e "create database wordpressdb;"
    mysql -uroot -pwordpress -e "grant all privileges on wordpressdb.* to wordpress@localhost identified by 'wordpress';"
  EOH
end


cookbook_file "/var/www/wordpress/wp-config.php" do
  source "wp-config.php"
  mode 0666
  owner "root"
  group "root"
end

service "apache2" do 
  action :restart
end
