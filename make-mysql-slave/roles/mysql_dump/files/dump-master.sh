#!/bin/bash

# Environment variables:
#
# * DATABASES      - list of databases to replicate
# * SSH_MASTER     - ssh connection string for master
# * SSH_SLAVE      - ssh connection string for slave
# * DB_MASTER_USER - username to use to dump master db, e.g. 'root'
# * DB_MASTER_PASS - password to use to dump master db, e.g. 'password'
# * DB_SLAVE_USER  - username to use to import dump from master db, e.g. 'root'
# * DB_SLAVE_PASS  - password to use to import dump from master db, e.g. 'password'
# * DB_REPL_USER   - username to use to connect to master db for replication, e.g. 'slave_replication'
# * DB_REPL_PASS   - password to use to connect to master db for replication, e.g. 'replication_password' (max 32 characters)
#

# be verbose
set -x

# die on non-zero exit code
set -e
set -o pipefail

# get temp file for dump
dumpfile=$(mktemp)

# Dump master DB without locking master mysql. This will include current bin log position
ssh -C $SSH_MASTER mysqldump --user="$DB_MASTER_USER" --password="$DB_MASTER_PASS" --skip-lock-tables --single-transaction --flush-logs --hex-blob --master-data=2 -B $DATABASES > $dumpfile


