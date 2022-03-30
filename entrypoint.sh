#!/bin/bash -x

diff=$(git diff-tree --no-commit-id --name-status -r ${GITHUB_SHA::7} --diff-filter=ACM | xargs)

action=$(echo $diff | awk '{print $1}')
file=$(echo $diff | awk '{print $2}')
env=$(echo $file | sed 's;/; ;g' | awk '{print $1}')
region=$(echo $file | sed 's;/; ;g' | awk '{print $2}')
service=$(echo $file | sed 's;/; ;g' | awk '{print $3}')
resource=$(echo $file | sed 's;/; ;g' | awk '{print $4}')

echo "Git action kind: " $action
echo "File path: " $file
echo "Environment: " $env
echo "Region: " $region
echo "Service: " $service
echo "Resource: " $resource
