command: """
IFS='|' read -r spotifyMsg <<<"$(osascript <<<'
        set appName to "Spotify"
        if application appName is running then
          tell application "Spotify"
          set theTrack to current track
          set theArtist to artist of theTrack
          set theName to name of theTrack
          return theArtist & " - " & theName
          end tell
        else
          set spotifyMsg to ""
          return spotifyMsg
        end if
        ')"
echo "$spotifyMsg"
"""

refreshFrequency: 5000

style: """
  -webkit-font-smoothing: antialiased
  color: #aaa
  font: 11px Source Code Pro
  bottom: 4px
  left: 50%
"""

render: (output) ->
  "<div class='spotify-info'></div>"

update: (output, domEl) ->
  $('.spotify-info').html(output)

  width = $('.spotify-info').width()
  width = width / 2

  $('.spotify-info').css('margin-left', -width)
