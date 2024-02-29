# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

import std/parseopt as po
from std/strformat import fmt
from system import quit, QUIT_SUCCESS, QUIT_FAILURE

# project imports
import version as version
import presets as presets

const DEBUG = false

proc show_help =
  echo(version.long())
  echo(version.compiled())
  echo(version.copyright())
  echo()
  echo(fmt"    {version.PROGRAM_NAME} [options]")
  echo()
  echo("Options for direct output:")
  echo("  --help         WARNING! Show this help and exit")
  echo("  --version      WARNING! Show version information and exit")
  echo("  --prototype    Display the prototype text without modification")
  echo("  --preset       WARNING! Display available presets")
  echo("  --preset:name  WARNING! Display a preset by name (if it exists)")
  echo()
  echo("Options for regular output:")
  echo("  --no-parens    Don't use parentheses")
  echo("  --no-this      Don't use 'This is a' in front of the text")
  quit(QUIT_SUCCESS)

proc direct_output(output: string) =
  quit(output, QUIT_SUCCESS)

proc debug_output_options(p_debug: var po.OptParser) =
  while true:
    p_debug.next()
    stdout.write(fmt"Option: ({p_debug.kind})")
    if p_debug.kind != po.cmdEnd:
      stdout.write(fmt" '{p_debug.key}' = '{p_debug.val}'")
    echo()
    if p_debug.kind == po.cmdEnd:
      break

proc output_preset(preset_name: string) =
  if preset_name == "":
    echo("Available presets:")
    for preset in presets.keys():
      echo(fmt"  - {preset}")
    quit(QUIT_SUCCESS)

  if not presets.check(preset_name):
    echo(fmt"No preset with given name: '{preset_name}'")
    quit(QUIT_FAILURE)

  direct_output(presets.lookup(preset_name))

type Options = object
  use_this: bool = true
  use_parens: bool = true

proc placeholder(options: Options): string =
  const
    this = "this is a"
    verb = "keep"
    particle = "from"
    article = "the"
    noun = "timeline"
    last_part = "clearing"

  result = fmt"placeholder to {verb} {article} {noun} {particle} {last_part}"

  if options.use_this:
    result = fmt"{this} {result}"

  if options.use_parens:
    result = fmt"({result})"

proc main =

  const options_long_no_val = @[
    "help",
    "version",
    "prototype",
    "no-parens",
    "no-this"
  ]

  var p = po.initOptParser(shortNoVal = {}, longNoVal = options_long_no_val)

  when DEBUG:
    var p_debug = p
    debug_output_options(p_debug)

  var display_options = Options()

  while true:
    p.next()
    case p.kind
      of po.cmdEnd:
        break
      of po.cmdShortOption, po.cmdLongOption:
        if p.key in options_long_no_val and p.val != "":
          quit(fmt"Command line option '{p.key}' doesn't take a value", QUIT_FAILURE)
        case p.key:
        # Options for direct output:
          of "help":
            show_help()
          of "version":
            direct_output(version.long())
          of "prototype":
            direct_output(presets.lookup("prototype"))
          of "preset":
            output_preset(p.val)
        # Options for regular output:
          of "no-parens":
            display_options.use_parens = false
          of "no-this":
            display_options.use_this = false
          else:
            quit(fmt"Unrecognized command line option '{p.key}'", QUIT_FAILURE)
      of po.cmdArgument:
        quit(fmt"This program doesn't take any non-option arguments: '{p.key}'", QUIT_FAILURE)

  echo(placeholder(display_options))

when isMainModule:
  main()
