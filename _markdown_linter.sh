#!/usr/bin/env bash
#
# Copyright 2019 Apex.AI, Inc.
# All rights reserved.

if [[ -n "$1" ]]; then
    FILE_PATH="$1" # $FilePath$
    shift
else
    echo "Error: The script shall be called with '\$FilePath\$' as parameter."
    echo "Expected usage: _markdown_linter.sh '\$FilePath\$' ['\$WorkspaceRoot\$'] [--fix]"
    exit 1
fi

if [ -n "$1" ] && [ -d "$1" ]; then
    WORKSPACE_ROOT="$1/"
    shift
elif [ -n "$1" ] && [ "$1" == "\$WorkspaceRoot\$" ]; then
    shift
    # Ignor this parameter for Colcon/CMake
fi

if [ -n "$1" ] && [ "$1" == "--fix" ]; then
    if [ "$1" == "--fix" ]; then
        FIX="$1"
        shift
    else
        echo "Error: Found unexpected parameter: $1"
    fi
fi

set -ex
markdownlint -c $WORKSPACE_ROOT../../.markdownlint.yaml $FIX $FILE_PATH
