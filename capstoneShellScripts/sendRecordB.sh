#!/bin/bash

trap '' SIGINT
trap '' SIGQUIT
trap '' SIGTSTP

while true
do

	echo "here we go again..."
	ssh pi@192.168.1.31 "arecord -D plughw:1,0 -f cd -d 5 pi-B.wav && scp pi-B.wav station@192.168.1.16:/home/station/audio-recieve/pi-B.wav && exit"
	cd ~/deepspeech/DeepSpeech
	PIB="$(./deepspeech --model models/output_graph.pbmm --alphabet models/alphabet.txt --lm models/lm.binary --trie models/trie --audio ~/audio-recieve/pi-B.wav)" 
	cd ~/sendosc
	./sendosc 192.168.1.26 14000 /speech s "$PIB"	
	echo "completed loop"
done
