#!/usr/bin/env bash

INDEX=0
TOTAL=12

for operation in $(seq $INDEX $(( TOTAL - 1 )))
do
    PERCENTAGE=$(echo "$INDEX / $TOTAL * 100" | bc -l)

    printf "Backing up computer (%.2f%% done).\r" "$PERCENTAGE"
    sleep 1

    INDEX=$(( INDEX + 1 ))
done

echo "Finished. $TOTAL folders saved.         "

exit 0
