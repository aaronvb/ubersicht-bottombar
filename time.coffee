command: "date +\"%H:%M\""

refreshFrequency: 10000 # ms

render: (output) ->
  "#{output}"

style: """
  -webkit-font-smoothing: antialiased
  color: #fff
  font: 11px Source Code Pro
  right: 6px
  bottom: 4px
"""
