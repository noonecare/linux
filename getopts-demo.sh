#!/usr/bin/env bash

function usage() {
    echo "Usage: $0 [-a <option>][-b <option>][-c]"
}

# getopts 为了 parse option(选项而生)。
while getopts a:b:c parm; do

case $parm in
    a)
        echo "-a is triggered"
        echo "$OPTARG"
        ;;
    b)
        echo "-b is triggered"
        ;;
    c)
        echo "-c is triggered"
        ;;
    *)
        usage
        echo "Invalid argument"
esac
done

shift $(((OPTIND-1)))

echo $1
echo $2
