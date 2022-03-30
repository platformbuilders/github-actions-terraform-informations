#!/bin/bash -x

diff=$(git diff-tree --no-commit-id --name-status -r ${GITHUB_SHA::7} --diff-filter=ACM | xargs)

echo action=$(echo $diff | awk '{print $1}') >> $GITHUB_ENV
echo file=$(echo $diff | awk '{print $2}') >> $GITHUB_ENV
echo env=$(echo $file | sed 's;/; ;g' | awk '{print $1}') >> $GITHUB_ENV
echo region=$(echo $file | sed 's;/; ;g' | awk '{print $2}') >> $GITHUB_ENV
echo service=$(echo $file | sed 's;/; ;g' | awk '{print $3}') >> $GITHUB_ENV
echo resource=$(echo $file | sed 's;/; ;g' | awk '{print $4}') >> $GITHUB_ENV

echo "Git action kind: " $action
echo "File path: " $file
echo "Environment: " $env
echo "Region: " $region
echo "Service: " $service
echo "Resource: " $resource
