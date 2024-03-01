# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

from std/strformat import fmt

const
  PROGRAM_NAME* = "placeholder"
  VERSION_MAJOR = 0
  VERSION_MINOR = 2
  VERSION_PATCH = 1
  COPYRIGHT_YEARS = "2024"
  COPYRIGHT_NAME = "András Németh"

proc short: string =
  result = fmt"{VERSION_MAJOR}.{VERSION_MINOR}.{VERSION_PATCH}"

proc long*: string =
  result = fmt"{PROGRAM_NAME} {short()}"

proc compiled*: string =
  result = fmt"Compiled on {COMPILE_DATE}"

proc copyright*: string =
  result = fmt"Copyright (c) {COPYRIGHT_YEARS} by {COPYRIGHT_NAME}"
