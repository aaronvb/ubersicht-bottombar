options =
  city          : "Honolulu"       # default city in case location detection fails
  region        : "HI"              # default region in case location detection fails
  units         : 'f'               # c for celcius. f for Fahrenheit
  staticLocation: false             # set to true to disable autmatic location lookup

command: "#{process.argv[0]} bottombar/get-weather \
                          \"#{options.city}\" \
                          \"#{options.region}\" \
                          #{options.units} \
                          #{'static' if options.staticLocation}"

refreshFrequency: 10000

render: (output) ->
  data    = JSON.parse(output)
  channel = data?.query?.results?.channel
  return @renderError(data) unless channel

  if channel.title == "Yahoo! Weather - Error"
    return @renderError(data, channel.item?.title)

  weather  = channel.item
  location = channel.location
  date     = new Date()
  temp = "#{Math.round(weather.condition.temp)}°"
  condition = weather.condition.text
  location_combined = location.city+', '+location.region

  message = "#{condition} #{temp} - #{location_combined}"

  "#{message}"

style: """
  -webkit-font-smoothing: antialiased
  color: #aaa
  font: 11px Source Code Pro
  right: 140px
  bottom: 4px
  text-align: right
"""

renderError: (data, message) ->
  console.error 'weather widget:', data.error if data?.error

  message ?= """
     Could not retreive weather data for #{data.location}.
  """

  "<div class=\"error\">#{message}<div>"
