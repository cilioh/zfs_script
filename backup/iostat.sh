#!/bin/bash

	iostat -d -m 1 | awk '$1=="nvme1n1" { n1 = $4 } $1=="nvme0n1" { print $4, n1 }' >> /mnt/share/cykim/result/${1} 2>&1

exit 0
