#!/bin/sh

cd diplodocus
./diplodocus.rb >> diplo.log 2>> diplo.error.log &
cd ..

cd reactbot
./reactbot.rb >> reactbot.log 2>> reactbot.error.log &
cd ..
