#!/bin/bash

files=($(find ./ -name 'Default.aspx'))

for file in "${files[@]}"; do
 path="${file%/*}"
 filecount="$(ls "${path}" | wc -l)"
 if [ "${filecount}" -ne 2 ]; then
  echo "- Path: ${path}
- Files: ${filecount}"
  if [ "${filecount}" -eq 1 ]; then
   ls "${path}"
  elif [ "${filecount}" -eq 3 ]; then
   if [ ! -e "${path}/config.xml" -o ! -e "${path}/Default.aspx" -o ! -e "${path}/thumbnail.gif" ]; then
    ls "${path}"
   fi
  fi
 fi
done
echo "All done."