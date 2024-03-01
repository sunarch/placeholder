# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

from std/strformat import fmt

const
  ProgramName* = "placeholder"
  VersionMajor = 0
  VersionMinor = 3
  VersionPatch = 0
  CopyrightYears = "2024"
  CopyrightName = "András Németh"

proc short: string =
  result = fmt"{VersionMajor}.{VersionMinor}.{VersionPatch}"

proc long*: string =
  result = fmt"{ProgramName} {short()}"

proc compiled*: string =
  result = fmt"Compiled on {COMPILE_DATE}"

proc copyright*: string =
  result = fmt"Copyright (c) {CopyrightYears} by {CopyrightName}"
