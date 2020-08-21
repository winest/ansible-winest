#!/bin/bash
CURR_DIR="$(dirname $(readlink -f ${0}))"

REMOTE_TAG_URL="https://api.github.com/repos/vim/vim/tags"
REMOTE_FILE_NAME=""
reName="^v([0-9]+?)\.([0-9]+?)\.([0-9]+?)$"

if [ -x "$(command -v wget)" ]; then
    REMOTE_FILE_NAME=$(wget -q "${REMOTE_TAG_URL}" -O - | jq -r ".[0].name")
elif [ -x "$(command -v curl)" ]; then
    REMOTE_FILE_NAME=$(curl -L -s "${REMOTE_TAG_URL}" | jq -r ".[0].name")
else
    echo "Cannot find wget or curl"
    exit -1
fi

REMOTE_FILE_URL="https://github.com/vim/vim/archive/${REMOTE_FILE_NAME}.tar.gz"
echo "REMOTE_FILE_URL=${REMOTE_FILE_URL}"
if [[ ${REMOTE_FILE_NAME} =~ ${reName} ]]; then
    MAJOR_VER="${BASH_REMATCH[1]}"
    MINOR_VER="${BASH_REMATCH[2]}"
    BUILD_VER="${BASH_REMATCH[3]}"

    if [ -x "$(command -v wget)" ]; then
        wget "${REMOTE_FILE_URL}" -O "${CURR_DIR}/vim-${MAJOR_VER}.${MINOR_VER}.${BUILD_VER}.tar.gz"
    elif [ -x "$(command -v curl)" ]; then
        curl -L "${REMOTE_FILE_URL}" -o "${CURR_DIR}/vim-${MAJOR_VER}.${MINOR_VER}.${BUILD_VER}.tar.gz" 
    else
        echo "Cannot find wget or curl"
        exit -1
    fi
fi
