#!/bin/sh
sed 's/\r//g' $1 > $1.tmp
mv $1.tmp $1
