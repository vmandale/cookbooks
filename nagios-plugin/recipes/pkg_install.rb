case node['platform']
	when "ubuntu","debian"
    		execute 'apt-get update' do
      			command 'apt-get update'
    		end
		
		%w{lynx gcc make cpp openssl xinetd libssl-dev}.each do |pkg|
    			package pkg do
      				action :install
    			end
  		end

	when "centos","redhat","fedora","scientific"

 		%w{make gcc gcc-c++ cpp openssl openssl-devel xinetd lynx}.each do |pkg|
    			package pkg do
      				action :install
    			end
  		end
end
