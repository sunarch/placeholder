import std/parseopt as po
import std/times as times
from std/strformat import fmt
from system import quit, QUIT_SUCCESS, QUIT_FAILURE

const
  DEBUG = false

const
  PROGRAM_NAME = "placeholder"
  VERSION_MAJOR = 0
  VERSION_MINOR = 2
  VERSION_PATCH = 0
  COPYRIGHT_YEARS = "2024"
  COPYRIGHT_NAME = "András Németh"

proc version(full = false): string =
  result = fmt"{VERSION_MAJOR}.{VERSION_MINOR}.{VERSION_PATCH}"
  if full:
    result = fmt"{PROGRAM_NAME} v{result}"

const
  PROTOTYPE = "(this is a placeholder to keep the timeline from clearing)"

var
  show_help_only = false
  show_version_only = false
  show_prototype = false
  use_parens = true
  use_this = true

proc current_date: string =
  result = times.now().format("yyyy-MM-dd")

proc show_help =
  echo(version(full = true))
  echo(fmt"Compiled on {current_date()}")
  echo(fmt"Copyright (c) {COPYRIGHT_YEARS} by {COPYRIGHT_NAME}")
  echo()
  echo("    {PROGRAM_NAME} [options]")
  echo()
  echo("Options:")
  echo("  --help       Show this help and exit")
  echo("  --version    Show version information and exit")
  echo("  --prototype  Display the prototype text without modification")
  echo("  --no-parens  Don't use parentheses")
  echo("  --no-this    Don't use 'This is a' in front of the text")

proc quit_cmd_option_unnecessary_value(option: string) =
  quit(fmt"Command line option '{option}' doesn't take a value", QUIT_FAILURE)

proc direct_output(output: string) =
  quit(output, QUIT_SUCCESS)

const options_long_no_val = @[
  "help",
  "version",
  "prototype",
  "no-parens",
  "no-this"
]
var p = po.initOptParser(shortNoVal = {}, longNoVal = options_long_no_val)
while true:
  p.next()
  when DEBUG:
    stdout.write(fmt"Option: ({p.kind})")
    if p.kind != po.cmdEnd:
      stdout.write(fmt" '{p.key}' = '{p.val}'")
    echo()
  case p.kind
    of po.cmdEnd:
      break
    of po.cmdShortOption, po.cmdLongOption:
      if p.key in options_long_no_val and p.val != "":
        quit_cmd_option_unnecessary_value(p.key)
      case p.key:
        of "help":
          show_help_only = true
        of "version":
          show_version_only = true
        of "prototype":
          show_prototype = true
        of "no-parens":
          use_parens = false
        of "no-this":
          use_this = false
        else:
          quit(fmt"Unrecognized command line option '{p.key}'", QUIT_FAILURE)
    of po.cmdArgument:
      quit(fmt"This program doesn't take any non-option arguments: '{p.key}'", QUIT_FAILURE)

if show_help_only:
  show_help()
  quit(QUIT_SUCCESS)

if show_version_only:
  direct_output(version(full = true))

if show_prototype:
  direct_output(PROTOTYPE)

const
  this = "this is a"
  verb = "keep"
  particle = "from"
  article = "the"
  noun = "timeline"
  last_part = "clearing"

proc placeholder: string =

  result = fmt"placeholder to {verb} {article} {noun} {particle} {last_part}"

  if use_this:
    result = fmt"{this} {result}"

  if use_parens:
    result = fmt"({result})"

echo(placeholder())
