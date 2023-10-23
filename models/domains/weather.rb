require './models/domains/temperature.rb'

class Weather
  attr_accessor :local_observation_date_time, :epoch_time, :weather_text,
    :weather_icon, :has_precipitation, :precipitation_time,
    :is_day_time, :temperature, :mobile_link, :link

  def initialize_from_response(c)
    temperature = Temperature.new
    temperature.initialize_from_response(c)
    @local_observation_date_time = c["LocalObservationDateTime"]
    @epoch_time = c["EpochTime"]
    @weather_text = c["WeatherText"]
    @weather_icon = c["WeatherIcon"]
    @has_precipitation = c["HasPrecipitation"]
    @precipitation_type = c["PrecipitationType"]
    @is_day_time = c["IsDayTime"]
    @mobile_link = c["MobileLink"]
    @link = c["Link"]
    @temperature = temperature
  end
end
