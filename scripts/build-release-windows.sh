#!/usr/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

CURRENT_DATE=$(date +"%Y-%m-%d")

# requires the MinGW-w64 toolchain

nim compile \
    --define:COMPILE_DATE:"$CURRENT_DATE" \
    --out:placeholder.exe --outdir:../build \
    -d:release -d:mingw \
    ../src/placeholder.nim
