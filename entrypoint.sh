#!/bin/bash -x

git diff-tree --no-commit-id --name-status -r ${GITHUB_SHA::7} --diff-filter=ACM >> diff.txt

while IFS= read -r line; do
    export diff_line=`echo $line | awk '{print $2}'`
    export diff_line=${diff_line%/*}
    echo $diff_line >> path_file.txt
done < "diff.txt"

sort -u path_file.txt >> path_file_sorted.txt

json=$(while IFS= read -r line; do
    export env=$(echo $line | sed 's;/; ;g' | awk '{print $1}')
    jq -n --arg env "$env" --arg path "$line" '{env: $env, path: $path}'
done < "path_file_sorted.txt" | jq -n '.items |= [inputs]')

echo json=$json >> $GITHUB_ENV
echo $json | jq '.'
rm -f*.txt
