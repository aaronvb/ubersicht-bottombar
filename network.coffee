command: """
    sar -n DEV 1 1 2> /dev/null |
    grep '[0-9].*en[0-9]' |
    {
    while read -r line;
    do
        downBytes=$(($downBytes + $(echo $line | awk '{down=$4} END {print down}')));
        upBytes=$(($upBytes + $(echo $line | awk '{up=$6} END {print up}')));
        result=$(echo "$downBytes $upBytes");
    done
    echo $result;
    }
"""
refreshFrequency: 3000

render: (output) ->
  usage = (bytes) ->
      kb = bytes / 1024
      usageFormat kb

  usageFormat = (kb) ->
      if kb > 1024
          mb = kb / 1024
          "#{parseFloat(mb.toFixed(1))} MB/s"
      else
          "#{parseFloat(kb.toFixed(2))} KB/s"

  lines = output.split " "

  downBytes = (Number) lines[0]
  upBytes = (Number) lines[1]

  "net <span class='up'>#{usage(upBytes)}</span> - <span class='down'>#{usage(downBytes)}</span>"

style: """
  -webkit-font-smoothing: antialiased
  font: 11px Source Code Pro
  bottom: 4px
  left: 215px
  color: #D5C4A1
  span.up
    color: #a26c3b
  span.down
    color: #139f75
"""
