#!/bin/bash -x

git diff-tree --no-commit-id --name-status -r ${GITHUB_SHA::7} --diff-filter=ACM | xargs >> diff.txt

while IFS= read -r line; do
    export diff_line=`echo $line | awk '{print $2}'`
    export diff_line=${diff_line%/*}
    echo $diff_line >> path_file.txt
done < "diff.txt"

sort -u path_file.txt >> path_file_sorted.txt

array=()
while IFS= read -r line; do
    array+=("[$line]")
done < "path_file_sorted.txt"

echo array_path=${array[@]} >> $GITHUB_ENV

# echo action=$(echo $diff | awk '{print $1}') >> $GITHUB_ENV
# echo file=$(echo $diff | awk '{print $2}') >> $GITHUB_ENV
# export file=$(echo $diff | awk '{print $2}')
# echo file_path=${file%/*} >> $GITHUB_ENV
# echo env=$(echo $file | sed 's;/; ;g' | awk '{print $1}') >> $GITHUB_ENV
# echo region=$(echo $file | sed 's;/; ;g' | awk '{print $2}') >> $GITHUB_ENV
# echo service=$(echo $file | sed 's;/; ;g' | awk '{print $3}') >> $GITHUB_ENV
# echo resource=$(echo $file | sed 's;/; ;g' | awk '{print $4}') >> $GITHUB_ENV

# echo "Git action kind: " $action
# echo "File path: " $file
# echo "Environment: " $env
# echo "Region: " $region
# echo "Service: " $service
# echo "Resource: " $resource
