#!/bin/bash
[ -d ./archive ] && exit

mkdir ./archive/

for S in `cat seqlist.txt`; do
	wget -c -P ./archive/ http://cvlab.hanyang.ac.kr/tracker_benchmark/seq/$S.zip
done

for S in `cat seqlist.txt`; do
    unzip ./archive/$S.zip
done

ln -sr Skating2 Skating2.1
ln -sr Skating2 Skating2.2
ln -sr Jogging Jogging.1
ln -sr Jogging Jogging.2
