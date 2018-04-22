#!/usr/bin/env bash
function date_range {
start_date=$1
end_date=$2
d=${start_date}

while [ "$d" != ${end_date} ]; do
  echo "$d"
  d=$(date -I -d "$d + 1 day")
done
}

date_range 2018-03-15 2018-04-19