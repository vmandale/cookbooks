# This will download latest available plugins and install on the system.
bash 'install_nagios_plugin' do
	user 'root'
	cwd '/tmp'
	code <<-EOH
		NAGIOS_PLUGIN_LINK=`lynx -dump nagios-plugins.org/downloads/ | egrep -i nagios-plugins- | egrep -i download | egrep -i ".tar.gz" | egrep -v sha | cut -d: -f2 | sed 's/^..//g'`
		NAGIOS_PLUGIN_TAR=`echo $NAGIOS_PLUGIN_LINK | rev | cut -d/ -f1 | rev`
		NAGIOS_PLUGIN_DIR=`echo $NAGIOS_PLUGIN_TAR | sed 's/.tar.*//g'`
		wget $NAGIOS_PLUGIN_LINK
		tar -xzf $NAGIOS_PLUGIN_TAR
		cd $NAGIOS_PLUGIN_DIR
		sh configure --with-nagios-user=nagios --with-nagios-group=nagios
		make
		make install
		chown nagios.nagios /usr/local/nagios
		chown -R nagios.nagios /usr/local/nagios/libexec
  	EOH
end
