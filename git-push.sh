#!/bin/bash

git add . -A
nowdate=`date "+%y%m%d-%H%M"`
echo $nowdate
git commit -m $nowdate
git push 
