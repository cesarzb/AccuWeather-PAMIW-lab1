require './models/domains/hourly_temperature'

class HourlyWeather
  attr_accessor :icon_phrase, :temperature

  def initialize_from_response(weather)
    @icon_phrase = weather["IconPhrase"]
    temperature = HourlyTemperature.new
    temperature.initialize_from_response(weather["Temperature"])
    @temperature = temperature
  end
end
