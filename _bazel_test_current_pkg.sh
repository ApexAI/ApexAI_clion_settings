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

RERUN=1

if [[ -n "$1" ]]; then
    RERUN=$1
    shift
fi


if [ -n "$PACKAGE" ]; then
    set -ex
    bazel test //$PACKAGE:all \
	--cache_test_results=no \
	--runs_per_test=$RERUN \
	--test_keep_going \
	--test_summary=detailed \
	--test_output=all \
	--test_verbose_timeout_warnings
else
    echo "Error: can't find package for $FILE_PATH file."
fi
