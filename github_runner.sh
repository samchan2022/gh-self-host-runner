#!/bin/bash

# Go to github and get the runner_token
#Add this following env to .env
# check env.example
#---------------------------------------------------
#runner_token=footoken
#username=samchan2022
#repo_name=nodejs-cicd-exercise
#---------------------------------------------------

# Load .env
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

docker run \
   -d \
  --restart always \
  --name "gh-runner-$repo_name"\
  -e REPO_URL="https://github.com/$username/$repo_name" \
  -e RUNNER_NAME="node-runner" \
  -e RUNNER_TOKEN="${runner_token}" \
  -e RUNNER_WORKDIR="/tmp/$repo_name" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /media/win/projects/public-github/$repo_name:/tmp/$repo_name \
  myoung34/github-runner:latest

#DEBUG only
  #-v /home/sam/tmp/entrypoint.sh:/entrypoint.sh \
  #-v /home/sam/tmp/config.sh:/actions-runner/config.sh \
  #--rm \
  #-it \
