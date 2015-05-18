#!/bin/bash

# Environment variables:
#
# * DATABASES      - list of databases to replicate
# * DB_MASTER_USER - username to use to dump master db, e.g. 'root'
# * DB_MASTER_PASS - password to use to dump master db, e.g. 'password'

# die on non-zero exit code
set -e
set -o pipefail

# get temp file for dump
dumpfile=$(mktemp)

# Dump master DB without locking master mysql. This will include current bin log position
mysqldump --user="$DB_MASTER_USER" --password="$DB_MASTER_PASS" --skip-lock-tables --single-transaction --flush-logs --hex-blob --master-data=2 -B $DATABASES | gzip > $dumpfile

echo $dumpfile
