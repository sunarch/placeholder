# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

import std/parseopt as po
from std/strformat import fmt

# project imports
import version as version
import presets as presets
when defined(DEBUG):
  import debug as debug

proc show_help =
  echo(version.long())
  echo(version.compiled())
  echo(version.copyright())
  echo()
  echo(fmt"    {version.ProgramName} [options]")
  echo()
  echo("Options for direct output:")
  echo("  --help         WARNING! Show this help and exit")
  echo("  --version      WARNING! Show version information and exit")
  echo("  --prototype    Display the prototype text without modification")
  echo("  --preset-list  WARNING! Display available presets")
  echo("  --preset:name  WARNING! Display a preset by name (if it exists)")
  echo()
  echo("Options for regular output:")
  echo("  --no-parens    Don't use parentheses")
  echo("  --no-this      Don't use 'This is a' in front of the text")
  quit(QuitSuccess)

type Options = object
  use_this: bool = true
  use_parens: bool = true

func placeholder(options: Options): string =
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
    "preset-list",
    "no-parens",
    "no-this"
  ]

  var p = po.initOptParser(shortNoVal = {}, longNoVal = options_long_no_val)

  when defined(DEBUG):
    var p_debug = p
    debug.output_options(p_debug)

  var display_options = Options()

  while true:
    p.next()
    case p.kind
      of po.cmdEnd:
        break
      of po.cmdShortOption, po.cmdLongOption:
        if p.key in options_long_no_val and p.val != "":
          quit(fmt"Command line option '{p.key}' doesn't take a value", QuitFailure)
        case p.key:
        # Options for direct output:
          of "help":
            show_help()
          of "version":
            quit(version.long(), QuitSuccess)
          of "prototype":
            quit(presets.prototype, QuitSuccess)
          of "preset-list":
            presets.list()
          of "preset":
            presets.output(p.val)
        # Options for regular output:
          of "no-parens":
            display_options.use_parens = false
          of "no-this":
            display_options.use_this = false
          else:
            quit(fmt"Unrecognized command line option '{p.key}'", QuitFailure)
      of po.cmdArgument:
        quit(fmt"This program doesn't take any non-option arguments: '{p.key}'", QuitFailure)

  echo(placeholder(display_options))

when isMainModule:
  main()
