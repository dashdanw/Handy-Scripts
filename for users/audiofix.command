#!/bin/sh
sudo kextunload /System/Library/Extensions/AppleHDA.kext
sudo kextload /System/Library/Extensions/AppleHDA.kext
sudo kill -9  `ps ax | grep [c]oreaudio | awk '{print $1}'`