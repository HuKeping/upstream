#!/bin/bash

set -e

unshallow_list=(
	"https://git.tukaani.org/xz-java.git"
	"https://git.tukaani.org/xz.git"
	"https://git.netfilter.org/arptables"
	"http://git.netfilter.org/ebtables"
	"https://git.netfilter.org/ipset"
	"https://git.netfilter.org/iptables"
	"http://git.netfilter.org/libnetfilter_conntrack"
)

declare -A unshallow_array

for i in ${unshallow_list[*]}
do
	unshallow_array[$i]=1
done

for i in $(cat upstream.yaml | grep "upstream: " | awk '{print $NF}')
do
	if [[ ${unshallow_array[$i]} ]]
	then
		git clone $i
	else
		git clone --depth 1 $i
	fi
done
