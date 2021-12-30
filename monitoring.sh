#!/bin/bash
arch=$(uname -a)
cpu=$(nproc --all)
vcpu=$(cat /proc/cpuinfo | grep processor | wc -l)
memuse=$(free -m | awk '$1 == "Mem:" {printf "%d/%dMB (%.1f%%)\n", $3, $2, $3*100/$2}')
diskuse=$(df -h | awk '$1 == "/dev/mapper/dhawkgir42--vg-root" {printf "%g/%gGb (%.1f%%)\n", $3, $2, $3*100/$2}')
cpuuse=$(top -bn1 | awk '$1 == "%Cpu(s):" {printf "%g%%\n", 100-$8}')
lastbt=$(who -b | awk '{print $3 " " $4}')
lvm=$(lsblk | grep 'lvm' | awk '{if ($1) {print "yes";exit;} else {print "no"} }')
connect=$(ss -tunlp | wc -l | awk '{print $1-1 " ESTABLISHED"}')
users=$(users | wc -w)
ip=$(hostname -I | awk '{print "IP " $1}')
mac=$(ip a | awk '$1 == "link/ether" {print $2}')
sudo=$(journalctl _COMM=sudo | grep COMMAND | wc -l | awk '{print $1 " cmd"}')
wall "	#Architecture: $arch
	#CPU physical: $cpu
	#vCPU: $vcpu
	#Memory Usage: $memuse
	#Disk Usage: $diskuse
	#CPU load: $cpuuse
	#Last boot: $lastbt
	#LVM use: $lvm
	#Connexions TCP: $connect
	#User log: $users
	#Network: $ip ($mac)
	#Sudo: $sudo"
