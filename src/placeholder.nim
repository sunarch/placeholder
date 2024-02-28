from std/strformat import fmt

# prototype:
# (this is a placeholder to keep the timeline from clearing)

const
    use_this = true
    this = "this is a"
    use_parens = true
    verb = "keep"
    particle = "from"
    article = "the"
    noun = "timeline"
    last_part = "clearing"

var
    output = fmt"placeholder to {verb} {article} {noun} {particle} {last_part}"

if use_this:
    output = fmt"{this} {output}"

if use_parens:
    output = fmt"({output})"

echo(output)
