#!/bin/bash

echo "MDS - mds2 node-------------------"
echo ""
ssh mds2 "zfs list"
echo "----------------------------------"
echo ""

echo "OSS1 - pm1 node-------------------"
echo ""
ssh pm1 "zfs list"
echo "----------------------------------"
echo ""

echo "OSS2 - pm2 node-------------------"
echo ""
ssh pm2 "zfs list"
echo "----------------------------------"
echo ""

echo "OSS3 - pm3 node-------------------"
echo ""
ssh pm3 "zfs list"
echo "----------------------------------"
echo ""



