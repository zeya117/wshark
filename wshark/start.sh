#!/bin/bash

#sudo mkdir -m 01777 /var/run/balance/

for i in {1..16}
do
	nohup broadwayd :$i & 
	export GDK_BACKEND=broadway
	export BROADWAY_DISPLAY=:$i
	wireshark-gtk -r /home/pi/Documents/StartSkript/http.cap --fullscreen -o gui.fileopen_remembered_dir:/home/pi/public_html/caps &
	#echo ""

done 

#servers=""
#
#for ii in {1..16}
#do
#
#	let port=8080+$ii
#	servers="$servers localhost:$port "
#
#done

#balance 9000 $servers

#echo $servers
#balance 10000 $servers
