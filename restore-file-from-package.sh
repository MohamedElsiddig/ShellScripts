#!/bin/bash

# Usage:
#
#     sudo ./restore-file-from-package.sh <filepath>
#
# Restore a file from the package that provides it.
#
# Source: http://askubuntu.com/a/67028/30482

set -x
set -e

FILE_TO_RESTORE=$(readlink -e $1)
mv -n ${FILE_TO_RESTORE} ${FILE_TO_RESTORE}.bak
apt-get -o Dpkg::Options::="--force-confmiss" install --reinstall $(dpkg -S ${FILE_TO_RESTORE} | head -1 | cut -d ':' -f1)
