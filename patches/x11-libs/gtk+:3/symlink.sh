#!/bin/sh
set -e
find -maxdepth 1 -type l -name "*.patch" -print -delete
count=0
for x in $(cat gtk3-classic/series | sed -e 's/#.*//'); do
    ln -sv gtk3-classic/$x $(printf '%04d' $count)-$x
    count=$(expr $count + 1)
done
