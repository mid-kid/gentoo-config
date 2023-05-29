#!/bin/sh
# Merge staging modprobed.db with currently installed one
cur=modprobed_6.1.db
cat modprobed.db "$cur" | sort | uniq > ".$cur"
mv ".$cur" "$cur"
