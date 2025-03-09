#!/bin/bash -e

(
    cd "$(dirname "$0")"

    FREQUENCY=${1:-daily}
    COUNT=${2:-0}

    BACKUP_FILE=/tmp/homeassistant-backup-${FREQUENCY}-${COUNT}.tar

    cp config/backups/*.tar ${BACKUP_FILE}

    lftp automation.home.tastic.nas -e "set ftp:ssl-allow no; mkdir -f -p ${FREQUENCY}; put -O ${FREQUENCY} ${BACKUP_FILE}; quit"

    echo -n "Successfully transferred : " ; du -h ${BACKUP_FILE}
)
