# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

from std/strformat import fmt
import std/tables as tables

# project imports
import exit as exit

let presets = tables.toTable({
  "prototype": "(this is a placeholder to keep the timeline from clearing)"
})

let keys = iterator(): string =
  for preset in presets.keys:
    yield preset

proc check(preset_name: string): bool =
  result = presets.hasKey(preset_name)

proc lookup(preset_name: string): string =
  if check(preset_name):
    result = ""
  result = presets[preset_name]

let prototype* = presets["prototype"]

proc output*(preset_name: string) =
  if preset_name == "":
    echo("Available presets:")
    for preset in keys():
      echo(fmt"  - {preset}")
    exit.success()

  if not check(preset_name):
    exit.failure_msg(fmt"No preset with given name: '{preset_name}'")

  exit.success_msg(lookup(preset_name))
