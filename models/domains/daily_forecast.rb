require './models/domains/daily_temperature'
require './models/domains/day'
require './models/domains/night'

class DailyForecast
  attr_accessor :temperature, :day, :night

  def initialize_from_response(forecast)
    temperature = DailyTemperature.new
    temperature.initialize_from_response(forecast["Temperature"])
    @temperature = temperature
    day = Night.new
    day.initialize_from_response(forecast["Day"])
    @day = day
    night = Night.new
    night.initialize_from_response(forecast["Night"])
    @night = night
  end
end
