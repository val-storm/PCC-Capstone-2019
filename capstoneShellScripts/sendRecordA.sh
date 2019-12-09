#!/bin/bash

trap '' SIGINT
trap '' SIGQUIT
trap '' SIGTSTP

while true
do

	echo "here we go again..."
	ssh pi@192.168.1.33 "arecord -D plughw:1,0 -f cd -d 5 pi-A.wav && scp pi-A.wav station@192.168.1.16:/home/station/audio-recieve/pi-A.wav && exit"
	cd ~/deepspeech/DeepSpeech
	PIA="$(./deepspeech --model models/output_graph.pbmm --alphabet models/alphabet.txt --lm models/lm.binary --trie models/trie --audio ~/audio-recieve/pi-A.wav)" 
	cd ~/sendosc
	./sendosc 192.168.1.26 14000 /speech s "$PIA"	
	echo "completed loop"
done
