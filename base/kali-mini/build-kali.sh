#!/bin/bash

# Fetch the latest Kali debootstrap script from git
apt-key adv --keyserver hkp://keys.gnupg.net --recv-keys 7D8D0BF6 &&\
curl "http://git.kali.org/gitweb/?p=packages/debootstrap.git;a=blob_plain;f=scripts/kali;hb=refs/heads/kali/master" > kali-debootstrap &&\
debootstrap kali-current ./kali-root http://http.kali.org/kali ./kali-debootstrap &&\
cd kali-root &&\
rm -rf var/lib/apt/lists/*  var/tmp/* var/cache/apt/archives/* &&\
tar cfvz /mnt/kali-root.tar.gz *  &&\
rm -rf var usr tmp srv sbin opt media home boot lib lib64 root bin &&\
echo "Build OK" || echo "Build failed!"
