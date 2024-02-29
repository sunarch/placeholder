# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

import std/times as times
from std/strformat import fmt

const
  PROGRAM_NAME* = "placeholder"
  VERSION_MAJOR = 0
  VERSION_MINOR = 2
  VERSION_PATCH = 0
  COPYRIGHT_YEARS = 2024
  COPYRIGHT_NAME = "András Németh"

proc current_date: string =
  result = times.now().format("yyyy-MM-dd")

proc short: string =
  result = fmt"{VERSION_MAJOR}.{VERSION_MINOR}.{VERSION_PATCH}"

proc long*: string =
  result = fmt"{PROGRAM_NAME} {short()}"

proc compiled*: string =
  result = fmt"Compiled on {current_date()}"

proc copyright*: string =
  result = fmt"Copyright (c) {COPYRIGHT_YEARS} by {COPYRIGHT_NAME}"
