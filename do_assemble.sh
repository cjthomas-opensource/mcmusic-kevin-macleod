#!/bin/bash

rm -rf output
mkdir output

cp aux/pack.mcmeta-1.19 output/pack.mcmeta

mkdir output/assets
mkdir output/assets/minecraft
mkdir output/assets/mcmusic_kevin_macleod
mkdir output/assets/mcmusic_kevin_macleod/sounds

cd music

for F in *mp3; do
  ffmpeg -vn -i $F ../output/assets/mcmusic_kevin_macleod/sounds/`echo $F|sed -e s/mp3/ogg/`
done
for F in *m4a; do
  ffmpeg -vn -i $F ../output/assets/mcmusic_kevin_macleod/sounds/`echo $F|sed -e s/m4a/ogg/`
done
for F in *webm; do
  ffmpeg -vn -i $F ../output/assets/mcmusic_kevin_macleod/sounds/`echo $F|sed -e s/webm/ogg/`
done

cd ..

./make_sound_json.pl output/ output/assets/minecraft/sounds.json

rm -f packages/*
cd output
zip -r ../packages/MCMusic_Kevin_Macleod.zip *
cd ..

rm -rf output

# This is the end of the file.
