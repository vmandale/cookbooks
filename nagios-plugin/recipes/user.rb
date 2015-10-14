# This will create the "nagios" user
user 'nagios' do
	comment 'Nagios User'
	shell '/bin/bash'
	home '/home/nagios'
end
