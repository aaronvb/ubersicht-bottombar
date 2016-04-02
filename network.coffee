command: "sar -n DEV 1 1 2> /dev/null | awk '/en0/{x++}x==2 {print $4,$6;exit}'"

refreshFrequency: 3000

render: (output) ->
  "net <span class='arrow'>↑ </span><span class='up'>0.00 KB/s</span> <span class='arrow'>↓ </span><span class='down'>0.00 KB/s</span>"

update: (output, domEl) ->
  result = output.split(' ')

  # Rather than just use KB and/or MB, let's accommodate all speeds
  # Pass "si" as true for base 10 (1 KiB = 1000 bytes)
  # Pass "si" as false for base 2 (1 kB = 1024 bytes)
  renderBytes = (bytes, type, si) ->
    bytes = Number(bytes)
    units = ['B']
    u = 0
    thresh = if si then 1000 else 1024
    if (bytes < thresh)
      units = ['B']
      u = 0
    else
      units = if si then ['kB','MB','GB','TB','PB','EB','ZB','YB'] else ['KiB','MiB','GiB','TiB','PiB','EiB','ZiB','YiB']
      u = -1
      loop
        bytes /= thresh
        ++u
        break if (bytes <= thresh)

      "#{bytes.toFixed(1)} #{units[u]}/s"

  $('.down').html renderBytes(result[0], 'IN', true)
  $('.up').html renderBytes(result[1], 'OUT', true)

style: """
  -webkit-font-smoothing: antialiased
  font: 11px Source Code Pro
  bottom: 4px
  left: 210px
  color: #D5C4A1
  span.up
    color: #da915c
  span.down
    color: #139f75
  span.arrow
    font-size: 10px
    font-weight: bold
    opacity: 0.4
"""
