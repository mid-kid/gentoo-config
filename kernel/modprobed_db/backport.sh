#!/bin/sh
# Merge staging modprobed.db with currently installed one
ver=6.6
cur="modprobed_$ver.db"
cat modprobed.db "$cur" | sort | uniq > ".$cur"
mv ".$cur" "$cur"
cur="firmwared_$ver.db"
cat firmwared.db "$cur" | sort | uniq > ".$cur"
mv ".$cur" "$cur"
