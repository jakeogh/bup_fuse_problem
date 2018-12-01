#!/bin/sh
set -o nounset
set -o errexit

timestamp=`date +%s`
mkdir "${timestamp}"
cd "${timestamp}"

mkdir source_file
wget https://i.redd.it/n6uc8p7yxjoz.jpg --output-document=source_file/n6uc8p7yxjoz.jpg

sha1sum source_file/n6uc8p7yxjoz.jpg # 01ca12c4daac369e7d9bd9d91e20c43de37707e2

bup --version # 0.29.1-158-g178805d

export BUP_DIR=bup_repo

mkdir bup_repo
bup init
bup index source_file
bup save --strip -n fuseproblemdemo source_file
bup ls fuseproblemdemo/latest/n6uc8p7yxjoz.jpg
bup cat-file fuseproblemdemo/latest/n6uc8p7yxjoz.jpg | sha1sum # 01ca12c4daac369e7d9bd9d91e20c43de37707e2

mkdir bup_fuse
#lsmod | grep "^fuse " || sudo modprobe fuse
bup fuse bup_fuse
tree bup_fuse

sha1sum bup_fuse/fuseproblemdemo/latest/n6uc8p7yxjoz.jpg # wrong! d3d62a846d1492c2e08aeb9bed04321e38252b5b

#sudo umount bup_fuse


