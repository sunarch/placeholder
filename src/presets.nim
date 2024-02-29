# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

import std/tables as tables

let presets = tables.toTable({
  "prototype": "(this is a placeholder to keep the timeline from clearing)"
})

let keys* = iterator(): string =
  for preset in presets.keys:
    yield preset

proc check*(preset_name: string): bool =
  result = presets.hasKey(preset_name)

proc lookup*(preset_name: string): string =
  if check(preset_name):
    result = ""
  result = presets[preset_name]
