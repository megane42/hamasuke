#!/bin/bash -e

cd $(dirname $0) # どこから実行してもこのスクリプトの位置がカレントディレクトリになるようにする

usage_exit() {
  echo "Usage: AWS_PROFILE=hamasuke $0 -e {staging,production} -c {command}" 1>&2
  exit 1
}

# parse options
while getopts 'e:c:' opt; do
  case "${opt}" in
    e) environment="${OPTARG}" ;;
    c) command="${OPTARG}" ;;
    *) usage_exit ;;
  esac
done

# check required options
if [[ -z "${environment}" ]]; then
  usage_exit
fi
if [[ -z "${command}" ]]; then
  usage_exit
fi

# ------------------------------------------------------------------------------------------

template=$(copilot task run --generate-cmd hamasuke/${environment}/web 2>&1)

# remove existing --entrypoint and --command
template=$(echo "${template}" | grep -v -- --entrypoint)
template=$(echo "${template}" | grep -v -- --command)

# append our --entrypoint and --command
template="${template} --entrypoint ''"
template="${template} --command '${command}'"

# stream the logs
template="${template} --follow"

# specify platform
template="${template} --platform-os linux --platform-arch arm64"

eval "${template}"
