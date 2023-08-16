#!/usr/bin/env bash
#
# Copyright 2019 Apex.AI, Inc.
# All rights reserved.

if [[ -n "$1" ]]; then
    FILE_PATH="$1" # $FilePathRelativeToProjectRoot$
    PACKAGE=$(bazel query $FILE_PATH --output=package)
    shift
else
    echo "Error: The script shall be called with '\$FilePathRelativeToProjectRoot\$' as parameter."
    exit 1
fi

if [ -n "$PACKAGE" ]; then
    PACKAGE_NAME=${PACKAGE##*/}
    set -ex
    bazel run --ui_event_filters=-info --run_under="cd $(pwd) &&" @apex//tools/repo:repo.fix -- \
	//$PACKAGE:all
else
    echo "Error: can't find package for $FILE_PATH file."
fi
