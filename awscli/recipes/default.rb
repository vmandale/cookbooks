# This will install the python, curl, unzip packages to the Linux system (Fedora, CentOS or RHEL)
for pkg in ['python', 'curl', 'unzip'] do
	package pkg do
		action :install
	end
end

# awscli Bundle Download
#####################
execute 'awscli-bundle-download' do
	command 'curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o /tmp/awscli-bundle.zip'
	notifies :run, 'execute[awscli-bundle-unzip]', :immediately
	notifies :run, 'execute[awscli-bundle-install]', :immediately
	not_if "test -f /usr/local/bin/aws"
end

# unzip awscli bundle
execute 'awscli-bundle-unzip' do
	command 'unzip -o /tmp/awscli-bundle.zip'
#	subscribes :run, 'resource[awscli-bundle-download]', :immediately
end

# install the bundle
execute 'awscli-bundle-install' do
	command './tmp/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws'
#	subscribes :run, 'resource[awscli-bundle-unzip]', :immediately
end
#############################

directory '/root/.aws' do
	action :create
	mode '0755'
	owner 'root'
	group 'root'
end

template '/root/.aws/config' do
	source 'aws_config.erb'
	mode '0400'
	owner 'root'
	group 'root'
end

template '/root/.aws/credentials' do
	source 'aws_credentials.erb'
	mode '0400'
	owner 'root'
	group 'root'
end

file '/tmp/awscli-bundle.zip' do
	action :delete
end

directory '/tmp/awscli-bundle' do
	action :delete
end
