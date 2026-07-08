#!/bin/sh
# Merge staging modprobed.db with currently installed one
ver=$(uname -r | cut -d. -f-2)
cur=modprobed_$ver.db
cat modprobed.db "$cur" | sort | uniq > ".$cur"
mv ".$cur" "$cur"
