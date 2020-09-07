#!/bin/bash

set -e

unshallow_list=(
	"http://git.netfilter.org/ebtables"
	"https://git.tukaani.org/xz-java.git"
	"https://git.tukaani.org/xz.git"
	"https://git.netfilter.org/arptables"
	"https://git.netfilter.org/ipset"
	"https://git.netfilter.org/iptables"
)

declare -A unshallow_array

for i in ${unshallow_list[*]}
do
	unshallow_array[$i]=1
done

for i in $(cat upstream.yaml | grep "upstream: " | awk '{print $NF}')
do
	echo "Sync $i ..."

	if [[ ${unshallow_array[$i]} ]]
	then
		git clone -q $i
	else
		git clone -q --depth 1 $i
	fi
done
