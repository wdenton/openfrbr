#!/bin/sh

for ISBN in `cat harry_potter_isbns.txt`
do
  ../../script/runner inject.rb $ISBN baf710b7fb8ebce3e4097b13f9f944e3
done

