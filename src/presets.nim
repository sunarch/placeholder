# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

from std/strformat import fmt
import std/tables as tables

let presets = tables.toTable({
  "prototype": "(this is a placeholder to keep the timeline from clearing)",
  "blank": "This post was intentionally left blank."
})

let keys = iterator(): string =
  for preset in presets.keys:
    yield preset

proc check(preset_name: string): bool =
  result = presets.hasKey(preset_name)

proc lookup(preset_name: string): string =
  if not check(preset_name):
    result = ""
  else:
    result = presets[preset_name]

let prototype* = presets["prototype"]

proc list* =
  echo("Available presets:")
  for preset in keys():
    echo(fmt"  - {preset}")
  quit(QuitSuccess)

proc output*(preset_name: string) =
  let preset_value = lookup(preset_name)
  case preset_value
    of "":
      quit(fmt"No preset with given name: '{preset_name}'", QuitFailure)
    else:
      quit(preset_value, QuitSuccess)
