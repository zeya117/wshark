#!/bin/bash

#sudo mkdir -m 01777 /var/run/balance/

servers=""

for ii in {1..16}
do

	let port=8080+$ii
	servers="$servers localhost:$port "

done

balance 9000 $servers
