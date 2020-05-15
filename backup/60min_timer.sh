#!/bin/bash

echo "START----------" >> /mnt/share/cykim/result/pm_waf1.txt
echo "START----------" >> /mnt/share/cykim/result/pm_waf2.txt
echo "START----------" >> /mnt/share/cykim/result/pm_waf3.txt

sleep 3600

echo "OFF" > /mnt/share/cykim/signal/breaksig

echo "END----------" >> /mnt/share/cykim/result/pm_waf1.txt
echo "END----------" >> /mnt/share/cykim/result/pm_waf2.txt
echo "END----------" >> /mnt/share/cykim/result/pm_waf3.txt

exit 0
