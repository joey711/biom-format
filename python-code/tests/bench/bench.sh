#!/bin/sh

# Author: Daniel McDonald
# Copyright 2012, BIOM Format
# This code is licensed under the GPL

#TIME_CMD='/usr/bin/time -f "%M %e"' # doesn't work on OS X
TIME_CMD='time'

SCRIPTS_DIR=$1
TABLES_DIR=$2

usage () {
    echo "usage: bench.sh <path_to_scripts> <path_to_tables>"
    exit 0;
}

if [ -z $SCRIPTS_DIR ]
then
    usage ;
fi

if [ -z $TABLES_DIR ]
then
    usage ;
fi

for f in `/bin/ls $SCRIPTS_DIR | grep "\.py$"`
do
    for t in `/bin/ls $TABLES_DIR`
    do
        $TIME_CMD python $SCRIPTS_DIR/$f $TABLES_DIR/$t 2> /tmp/foo
        if [ $? -ne 0 ]
        then
            continue
        else
            foo=`cat /tmp/foo`
            echo "$f\t$t\t$foo" >> bench_results.txt
        fi
    done
done
