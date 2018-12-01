#!/bin/sh
set -o nounset
set -o errexit

timestamp=`date +%s`
mkdir "${timestamp}"
cd "${timestamp}"

mkdir source_file
cp ../c30058e6e9f5c505302cf157c834a14255e72afe source_file

sha1sum source_file/c30058e6e9f5c505302cf157c834a14255e72afe # c30058e6e9f5c505302cf157c834a14255e72afe

bup --version # 0.29.1-158-g178805d

export BUP_DIR=bup_repo

mkdir bup_repo
bup init
bup index source_file
bup save --strip -n fuseproblemdemo source_file
bup ls fuseproblemdemo/latest/c30058e6e9f5c505302cf157c834a14255e72afe
bup cat-file fuseproblemdemo/latest/c30058e6e9f5c505302cf157c834a14255e72afe | sha1sum #

mkdir bup_fuse
#lsmod | grep "^fuse " || sudo modprobe fuse
bup fuse bup_fuse
tree bup_fuse

sha1sum bup_fuse/fuseproblemdemo/latest/c30058e6e9f5c505302cf157c834a14255e72afe # wrong! cb506b5cb83c1965e7d3442a42c9134e44819f18

#sudo umount bup_fuse


