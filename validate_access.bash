#!/bin/bash

set -e

unshallow_list=(
	"http://git.netfilter.org/ebtables"
	"https://anongit.mindrot.org/openssh.git"
	"https://git.tukaani.org/xz-java.git"
	"https://git.tukaani.org/xz.git"
	"https://git.netfilter.org/arptables"
	"https://git.netfilter.org/ipset"
	"https://git.netfilter.org/iptables"
)

Mercurial_list=(
	"https://gmplib.org/repo/gmp"
)

declare -A unshallow_array
declare -A Mercurial_array

for i in ${unshallow_list[*]}
do
	unshallow_array[$i]=1
done

for i in ${Mercurial_list[*]}
do
	Mercurial_array[$i]=1
done

for i in $(cat upstream.yaml | grep "upstream: " | awk '{print $NF}')
do
	echo "Sync $i ..."
	repo_name=$(echo $i | awk -F/ '{print $NF}')
	rm -rf $repo_name

	if [[ ${Mercurial_array[$i]} ]]
	then
		hg -q clone $i $repo_name
		continue
	fi

	if [[ ${unshallow_array[$i]} ]]
	then
		git clone -q $i $repo_name
	else
		git clone -q --depth 1 $i $repo_name
	fi
done
