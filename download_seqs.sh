#!/bin/bash
[-f ./sequences/ ] && return

mkdir ./sequences/
mkdir ./sequences/archive/

for S in `cat seqlist.txt`; do
	wget -c -P ./sequences/archive/ http://cvlab.hanyang.ac.kr/tracker_benchmark/seq/$S.zip
done
