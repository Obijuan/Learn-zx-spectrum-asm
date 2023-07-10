#!/bin/sh

./build.sh $1
zesarux --disable-all-first-aid --nowelcomemessage --quickexit $1.tap