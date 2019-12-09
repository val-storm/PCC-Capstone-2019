#!/bin/bash

trap '' SIGINT
trap '' SIGQUIT
trap '' SIGTSTP

while true
do

	echo "here we go again..."
	ssh pi@192.168.1.34 "arecord -D plughw:1,0 -f cd -d 5 pi-C.wav && scp pi-C.wav station@192.168.1.16:/home/station/audio-recieve/pi-C.wav && exit"
	cd ~/deepspeech/DeepSpeech
	PIC="$(./deepspeech --model models/output_graph.pbmm --alphabet models/alphabet.txt --lm models/lm.binary --trie models/trie --audio ~/audio-recieve/pi-C.wav)" 
	cd ~/sendosc
	./sendosc 192.168.1.26 14000 /speech s "$PIC"	
	echo "completed loop"
done
