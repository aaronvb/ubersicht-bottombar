command: "pmset -g batt | egrep '([0-9]+\%).*' -o --colour=auto | cut -f1 -d';'"

refreshFrequency: 150000 # ms

render: (output) ->
  "bat <span>#{output}</span>"

style: """
  -webkit-font-smoothing: antialiased
  font: 11px Source Code Pro
  bottom: 4px
  left: 140px
  color: #D5C4A1
  span
    color: #a7a65d
"""
