#!/bin/bash
AYOOLA_BIN=/ayoola/bin/
mkdir -p $AYOOLA_BIN
INSTALL_FILENAME=${AYOOLA_BIN}server_monitor.sh
rm $INSTALL_FILENAME
cat > $INSTALL_FILENAME <<"HEREDOC"
#!/bin/bash
echo "Monitoring server";
trigger=50;
#NO_OF_CORE=$(grep pro /proc/cpuinfo -c);
load=`cat /proc/loadavg | awk '{print $1}'`;
response=`echo | awk -v T=$trigger -v L=$load 'BEGIN{if ( L > T){ print "greater"}}'`;
echo "SERVER LOAD: $load";
echo "CORES: $NO_OF_CORE";
if [[ $response = "greater" ]]
then
echo "GETTING TOP";
LOADDETAILS="$(ps -eo pmem,pcpu,args,ruser=RealUser | sort -k 1 -r | less)";
#echo "LOAD DETAILS";
#echo "$LOADDETAILS";
sar -q | echo "$LOADDETAILS" | mail -s"High load on server - [ $load ]" hostmaster@example.com;
echo "MAIL SENT";
reboot;
else
echo "Present load seems fine...";
fi
HEREDOC

#	MAKE IT EXECUTABLE
chmod 755 $INSTALL_FILENAME

#	RUN THE INSTALLER
$INSTALL_FILENAME

CRON_JOB="*/5 * * * * $INSTALL_FILENAME"
cat <(fgrep -i -v "$INSTALL_FILENAME" <(crontab -l)) <(echo "$CRON_JOB") | crontab -

