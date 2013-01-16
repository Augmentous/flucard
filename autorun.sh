#!/bin/sh

mv /mnt/sd/log.txt /mnt/sd/log.txt.old
rm /mnt/sd/log.txt


is_prevent_auto_start_wifi=no
ln -s /mnt/sd/deploy/bin/* /bin/
ln -s /mnt/sd/deploy/usr/bin/* /usr/bin/
ln -s /mnt/sd/deploy/usr/local /usr/local
ln -s /mnt/sd/deploy/usr/lib /usr/lib
ln -s /mnt/sd/deploy/usr/include /usr/include
ln -s /mnt/sd/deploy/usr/libexec /usr/libexec
ln -s /mnt/sd/deploy/sbin/* /sbin/
ln -s /mnt/sd/deploy/lib/* /lib/
ln -s /mnt/sd/deploy/etc/* /etc/
ln -s /mnt/sd/deploy/www/* /www/
ln -s /mnt/sd/deploy/www/cgi-bin/* /www/cgi-bin/
ln -s /mnt/sd/deploy/busybox /bin/awk
rm /bin/dd
ln -s /mnt/sd/deploy/busybox /bin/dd
ln -s /mnt/sd/deploy/busybox /bin/find
ln -s /mnt/sd/deploy/busybox /bin/grep
ln -s /mnt/sd/deploy/busybox /bin/hexdump
ln -s /mnt/sd/deploy/busybox /bin/killall
ln -s /mnt/sd/deploy/busybox /bin/less
ln -s /mnt/sd/deploy/busybox /bin/passwd
ln -s /mnt/sd/deploy/busybox /bin/sed
ln -s /mnt/sd/deploy/busybox /bin/tar
ln -s /mnt/sd/deploy/busybox /bin/telnetd
ln -s /mnt/sd/deploy/busybox /bin/watch
ln -s /mnt/sd/deploy/busybox /bin/whoami
rm /usr/sbin/ftpd
rm /usr/bin/tcpsvd
ln -s /mnt/sd/deploy/busybox /usr/sbin/ftpd
ln -s /mnt/sd/deploy/busybox /usr/bin/tcpsvd
rm /usr/bin/w2
chmod 777 /usr/bin/deploy/w2
ln -s /mnt/sd/deploy/w2 /usr/bin/w2
chmod 777 /mnt/sd/deploy/w2
chmod 777 /mnt/sd/deploy/upload.rb
mkdir /mnt/sd/DCIM/thumbs
mkdir /mnt/sd/DCIM_t

# OK Done Init

# Start
buzzer -t 1; sleep 0.25; buzzer -t 0
buzzer -t 1; sleep 0.25; buzzer -t 0

# find /mnt/sd/DCIM/ | grep -v "thumb" | grep -v "TREK" | grep -v "MISC" | grep -i "jpg" > /tmp/allnewfiles
# find /mnt/sd/DCIM/ | grep -v "thumb" | grep -v "TREK" | grep -v "MISC" | grep -i "jpg" > /tmp/alloutfiles
# cat /mnt/mtd/prevfiles >> /tmp/allnewfiles
#/mnt/sd/deploy/busybox sort -g /tmp/allnewfiles > /tmp/allnewfiles2
#/mnt/sd/deploy/busybox uniq -u /tmp/allnewfiles2 > /tmp/allnewfiles3

find /mnt/sd/DCIM/ | grep -v "thumb" | grep -v "TREK" | grep -v "MISC" | grep -i "jpg" | sed 's/\/mnt\/sd\/DCIM\///' > /tmp/allnewfiles
# find /mnt/sd/DCIM_t/ | grep -v "thumb" | grep -v "TREK" | grep -v "MISC" | grep -i "jpg" | sed 's/\/mnt\/sd\/DCIM_t\///' >> /tmp/allnewfiles
cat /mnt/sd/done.txt >> /tmp/allnewfiles
/mnt/sd/deploy/busybox sort -g /tmp/allnewfiles > /tmp/allnewfiles2
/mnt/sd/deploy/busybox uniq -u /tmp/allnewfiles2 > /tmp/allnewfiles3

cat /mnt/sd/done.txt >> /tmp/allnewfiles4
cat /mnt/sd/uploaded.txt >> /tmp/allnewfiles4
/mnt/sd/deploy/busybox sort -g /tmp/allnewfiles4 > /tmp/allnewfiles5
/mnt/sd/deploy/busybox uniq -u /tmp/allnewfiles5 > /tmp/allnewfiles6


grep -c "^" /tmp/allnewfiles3 > /tmp/newfilescount
num=`cat /tmp/newfilescount`
# if we have enough file. more than 10 and 11 or 21 or 31.. 
#if [ $((num%10)) == 1 ] 
#then
	if [ $num -gt 10 ]
	then
		# then for all the non-thumbnails and non-gopro files, thumbnail them
		# find /mnt/sd/DCIM/ | grep -v "thumb" | grep -v "TREK" > /tmp/newpics
		
		killall udhcpd
		w2
		#		mount -t devpts /dev/pts
		#		dropbear -A -N root -C admin -U 0 -G 0 &



		for a in `cat /tmp/allnewfiles3`
		do
			buzzer -t 1; sleep 0.25; buzzer -t 0
			echo $a >> /mnt/sd/log.txt
			php /mnt/sd/deploy/cliexift.php /mnt/sd/DCIM/$a >> /mnt/sd/log.txt
			echo $a >> /mnt/sd/done.txt
			sync
		done

		buzzer -t 1; sleep 0.25; buzzer -t 0
		buzzer -t 1; sleep 0.25; buzzer -t 0
		buzzer -t 1; sleep 0.25; buzzer -t 0
		buzzer -t 1; sleep 0.25; buzzer -t 0
		/mnt/sd/deploy/upload.rb
		buzzer -t 1; sleep 0.25; buzzer -t 0
		buzzer -t 1; sleep 0.25; buzzer -t 0
		buzzer -t 1; sleep 0.25; buzzer -t 0
		buzzer -t 1; sleep 0.25; buzzer -t 0
	fi
#fi

buzzer -t 1; sleep 0.25; buzzer -t 0
buzzer -t 1; sleep 0.25; buzzer -t 0
# else shutdown

sync



#killall httpd
#echo 8 >> /mnt/sd/log.txt
#httpd -h /www -c /etc/httpd.conf&
#echo 9 >> /mnt/sd/log.txt

## tcpsvd 0.0.0.0 21 ftpd -w /&
## sleep 1
## echo "6" >> /mnt/sd/log.txt
## buzzer -t 6

#killall telnetd
#echo 10 >> /mnt/sd/log.txt
#sleep 1
#echo 11 >> /mnt/sd/log.txt
#mount -t devpts /dev/pts
#echo 12 >> /mnt/sd/log.txt
#/mnt/sd/deploy/busybox telnetd -l /bin/sh &
#echo 13 >> /mnt/sd/log.txt
#sleep 1
#echo 14 >> /mnt/sd/log.txt
#dropbear -A -N root -C admin -U 0 -G 0 &
#echo 15 >> /mnt/sd/log.txt

#### UAP
# uap
# echo "uap" >> /mnt/sd/log.txt

#### W2
#echo 16 >> /mnt/sd/log.txt
#killall udhcpd
#echo 17 >> /mnt/sd/log.txt
# Should Wait for the net to come up
#w2
#echo 18 >> /mnt/sd/log.txt
#echo "w2" >> /mnt/sd/log.txt
#ifconfig >> /mnt/sd/log.txt
sleep 1
sync
#buzzer -t 1; sleep 0.25; buzzer -t 0
#buzzer -t 1; sleep 0.25; buzzer -t 0
#buzzer -t 1; sleep 0.25; buzzer -t 0
#buzzer -t 1; sleep 0.25; buzzer -t 0
#/mnt/sd/deploy/upload.rb
#buzzer -t 1; sleep 0.25; buzzer -t 0
#buzzer -t 1; sleep 0.25; buzzer -t 0
#buzzer -t 1; sleep 0.25; buzzer -t 0
#buzzer -t 1; sleep 0.25; buzzer -t 0



# END
buzzer -t 6; sleep 2; buzzer -t 0;
