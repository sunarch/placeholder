# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

import std/parseopt as po
from std/strformat import fmt

# project imports
import version as version
import presets as presets
import exit as exit

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
  exit.success()

proc debug_output_options(p_debug: var po.OptParser) =
  while true:
    p_debug.next()
    stdout.write(fmt"Option: ({p_debug.kind})")
    if p_debug.kind != po.cmdEnd:
      stdout.write(fmt" '{p_debug.key}' = '{p_debug.val}'")
    echo()
    if p_debug.kind == po.cmdEnd:
      break

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
          exit.failure_msg(fmt"Command line option '{p.key}' doesn't take a value")
        case p.key:
        # Options for direct output:
          of "help":
            show_help()
          of "version":
            success_msg(version.long())
          of "prototype":
            success_msg(presets.prototype)
          of "preset":
            presets.output(p.val)
        # Options for regular output:
          of "no-parens":
            display_options.use_parens = false
          of "no-this":
            display_options.use_this = false
          else:
            exit.failure_msg(fmt"Unrecognized command line option '{p.key}'")
      of po.cmdArgument:
        exit.failure_msg(fmt"This program doesn't take any non-option arguments: '{p.key}'")

  echo(placeholder(display_options))

when isMainModule:
  main()
