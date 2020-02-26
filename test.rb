require "forecast_io"
                                 

# enter your Dark Sky API key here
ForecastIO.api_key = "ad6d87ce0b95666e8acfc495665df190"

forecast = ForecastIO.forecast(37, -87).to_hash

day = forecast["daily"]["data"][1]

puts Time.at(day["time"]).strftime("%a")
