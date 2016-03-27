command: "date +\"%a %b %d\""

refreshFrequency: 10000

render: (output) ->
  "#{output}"

style: """
  -webkit-font-smoothing: antialiased
  color: #fff
  font: 11px Source Code Pro
  right: 55px
  bottom: 4px
"""
