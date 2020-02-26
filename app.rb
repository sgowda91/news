require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "ad6d87ce0b95666e8acfc495665df190"

#Enter NewsAPI key
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=8f07e516edfb454b84cbbed7239540fb"

get "/" do
    view "location"
  # show a view that asks for the location
end

get "/news" do
    @location = params["q"]
    results = Geocoder.search(params["q"])
    @lat_long = results.first.coordinates # => [lat, long]
    @forecast = ForecastIO.forecast(@lat_long[0], @lat_long[1]).to_hash
    @current_temperature = @forecast["currently"]["temperature"]
    @conditions = @forecast["currently"]["summary"]
    @forecast_daily = @forecast["daily"]["data"]
    # @forecast_array = @forecast["daily"]["data"]
    # @days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

    @news = HTTParty.get(url).parsed_response.to_hash
    # news_headline = news["articles"]

    view "ask"
    # "In #{@location}, it is currently #{@current_temperature} and #{@conditions}"
    # "In #{@location}, it is currently #{@current_temperature} and #{@conditions}"

    # forecast_array.each_index do |i|
    #      "A high temperature of #{forecast_array[i]["temperatureHigh"]} and #{forecast_array["summary"]} for #{days[i]}"
    # end     
end
