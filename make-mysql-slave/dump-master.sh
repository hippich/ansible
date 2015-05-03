#!/bin/bash

# Dump master DB without locking master mysql. This will include current bin log position
ssh -C user@192.168.58.100 mysqldump -u root --skip-lock-tables --single-transaction --flush-logs --hex-blob --master-data=2 -B $DATABASES
