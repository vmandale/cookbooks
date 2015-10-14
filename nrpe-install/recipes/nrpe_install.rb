# This will download latest available plugins and install on the system.
bash 'install_nrpe' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
   NRPE_BASE=`lynx -dump -listonly sourceforge.net/projects/nagios/files | egrep -i nrpe- | egrep -iv "timeline" | cut -d: -f2 | sed 's/^..//g'`
   NRPE_LATEST_DIR=`lynx -dump -listonly $NRPE_BASE | egrep -i nrpe- | egrep -iv "timeline" | head -1 | cut -d: -f2 |  sed 's/^..//g'`
   NRPE_LATEST_PKG_LINK=`lynx -dump -listonly $NRPE_LATEST_DIR | egrep -i nrpe- | egrep -i download | cut -d: -f2 | sed 's/^/http:/g' | sed 's/.download//g'`
   NRPE_LATEST_TAR=`echo $NRPE_LATEST_PKG_LINK | rev | cut -d/ -f1 | rev`
   NRPE_DIR=`echo $NRPE_LATEST_TAR | sed 's/.tar.*//g'`
   
   cd /tmp
   wget $NRPE_LATEST_PKG_LINK
   tar -xzf $NRPE_LATEST_TAR
   cd $NRPE_DIR
   sh configure --with-nagios-user=nagios --with-nagios-group=nagios > /tmp/configure.out 2> /tmp/config.error
   if [ $? -gt 0 ]; then
echo "Could not install. Please fix the error and then re-configure. You may read the README file to get help on installation"
echo "The package is available at $PWD"
exit
fi

make all
make install-plugin
make install-daemon
make install-daemon-config
make install-xinetd

echo "PATH=\$PATH:/usr/local/nagios/bin" >> /etc/profile

echo -e "nrpe\t5666/tcp\t\t# NRPE" >> /etc/services

#sed -i 's/only_from.*/only_from       = 127.0.0.1 <NAGIOS_MASTER>/g' /etc/xinetd.d/nrpe
#sed -i 's/allowed_hosts=.*/allowed_hosts=127.0.0.1, <NAGIOS_MASTER>/g' /usr/local/nagios/etc/nrpe.cfg
service xinetd restart
#iptables -I RH-Firewall-1-INPUT -p tcp -m tcp –dport 5666 -j ACCEPT
#service iptables save   
  EOH
end

template '/etc/xinetd.d/nrpe' do
 source 'nrpe.erb'
 mode '0644'
 owner 'root'
 group 'root'
end

execute 'Update-nrpe.cfg' do
 command "sed -i 's/allowed_hosts=.*/allowed_hosts=127.0.0.1, #{[node][:nrpe-install][:nagios_master]}/g' /usr/local/nagios/etc/nrpe.cfg"
end

service 'xinetd' do
 action :restart
end
