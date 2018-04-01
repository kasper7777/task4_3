#!/bin/bash

backup="/tmp/backups/"
if [ ! -d "${backup}" ]; then mkdir "${backup}"; fi
if [ "$#" -ne 2 ]; then echo "wrong input" >&2; exit 1; fi

if ! [[ -d $1 ]]; then echo "$1: directory not found" >&2; exit 2; fi
if [[ $2 =~ '^[0-9]+$' ]]; then echo "$2 wrong number" >&2; exit 3; fi

name_dir=$(echo $1 | sed -r 's/[/]+/-/g' | sed 's/^-//')
arhiv=${name_dir}-$(date '+%Y%m%d-%H%M%S').tar.gz
tar --create --gzip --file="$backup$arhiv" "$1" 2> /dev/null

find "$backup" -name "${name_dir}*" -type f -printf "${backup}%P\n"| sort -n | head -n -"$2" | sed "s/.*/\"&\"/"| xargs rm -f

exit 0

