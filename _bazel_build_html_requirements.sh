#!/usr/bin/env bash
#
# Copyright 2019 Apex.AI, Inc.
# All rights reserved.

set -ex
bazel run //apex_internal/tools/apex_doc_tools:apex_doc -- requirements

firefox ../reqs/build/index.html&