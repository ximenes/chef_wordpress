WordPress latest Cookbook
================

 - Author: Eduardo Ximenes Soares <duximenes@gmail.com>
 - Cookbook install and configure: WordPress latest
 - Test: chef-solo AMI UBNTU SERVER EC2 | UBUNTU SERVER 


HowTo
------------------

 - Install GIT client

 - Install chef solo
	- curl -L https://www.opscode.com/chef/install.sh | bash

 - Download and configure CHEF-REPO structure
	- wget http://github.com/opscode/chef-repo/tarball/master
	- tar -zxvf master  
	- mv opscode-chef-repo-f9d4b0c/ /opt/chef-repo
	- mkdir /opt/chef-repo/.chef
 
 - Configure cookbook path (/opt/chef-repo/.chef/knife.rb)
	- Add line
		- cookbook_path [ '/opt/chef-repo/cookbooks' ]
 
 - Configure solo.rb (/opt/chef-repo/solo.rb)
	- Add lines:
		- file_cache_path "/opt/chef-solo"
		- cookbook_path "/opt/chef-repo/cookbooks"

 - Download REPO: 
	- git clone https://github.com/ximenes/chef_wordpress.git  -l /opt/chef-repo/cookbooks/wordpress

 - Create your json (/opt/chef-repo/JSON_NAME.json)
	- Add line: 
		-  {   "run_list": [ "recipe[wordpress]" ] } 

 - Execute CHEF-SOLO
	- chef-solo -c /opt/chef-repo/solo.rb -j /opt/chef-repo/JASON_NAME.json


 - Access URL:
	- http://YOUR_IP/wordpress
	- http://192.168.1.1/wordpress


