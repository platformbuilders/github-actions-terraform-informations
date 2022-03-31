#!/bin/bash -x

for file in $1; do
    echo $file"\n" >> diff.txt
done

while IFS= read -r line; do
    export diff_line=`echo $line | awk '{print $2}'`
    export diff_line=${diff_line%/*}
    echo $diff_line >> path_file.txt
done < "diff.txt"

sort -u path_file.txt >> path_file_sorted.txt

json=$(while IFS= read -r line; do
    export env=$(echo $line | sed 's;/; ;g' | awk '{print $1}')
    jq -n --arg env "$env" --arg path "$line" '{env: $env, path: $path}'
done < "path_file_sorted.txt" | jq -n '.include |= [inputs]')

json=$(echo $json | sed 's/"/\\"/g' | sed -e 's/ //g' )
echo json=$json >> $GITHUB_ENV
echo $json | jq '.'
rm -f *.txt
