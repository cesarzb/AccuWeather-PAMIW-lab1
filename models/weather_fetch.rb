require 'json'
require 'net/http'
require 'uri'
require 'open-uri'
require './models/city'
require './models/country'
require './models/administrative_area'
require './models/weather'
require './models/hourly_weather'
require './models/daily_forecast'

class AccuWeatherService
  BASE_URL = 'http://dataservice.accuweather.com'
  CURRENT_CONDITIONS_ENDPOINT = 'currentconditions/v1/%s?apikey=%s&language=%s&metric=true'
  ONE_DAILY_FORECAST_ENDPOINT = "forecasts/v1/daily/1day/%s?apikey=%s&language=%s&metric=true"
  FIVE_DAILY_FORECASTS_ENDPOINT = "forecasts/v1/daily/5day/%s?apikey=%s&language=%s&metric=true"
  ONE_HOUR_FORECASTS_ENDPOINT = "forecasts/v1/hourly/1hour/%s?apikey=%s&language=%s&metric=true"
  TWELVE_HOURS_FORECASTS_ENDPOINT = "forecasts/v1/hourly/12hour/%s?apikey=%s&language=%s&metric=true"
  AUTOCOMPLETE_ENDPOINT = "locations/v1/cities/autocomplete?apikey=%s&q=%s&language=%s&metric=true"

  def initialize
    # Load API key and language settings from environment variables or a .env file
    @api_key = "DpNF5q9QMia63SaV0lh6HPZCbJGNMYnW"
    @language = "pl"
  end

  def get_locations(location_name)
    encoded_location_name = URI.encode_www_form_component(location_name)
    uri = URI("#{BASE_URL}/#{AUTOCOMPLETE_ENDPOINT % [@api_key, encoded_location_name, @language]}")
    response = Net::HTTP.get_response(uri)
    json = response.body
    cities = JSON.parse(json)
    cities.map! do |c|
      city = City.new
      city.initialize_from_response(c)
      city
    end
    cities
  end

  def get_current_conditions(city_key)
    uri = URI("#{BASE_URL}/#{CURRENT_CONDITIONS_ENDPOINT % [city_key, @api_key, @language]}")
    response = Net::HTTP.get_response(uri)
    json = response.body
    weathers = JSON.parse(json)
    weather = Weather.new
    weather.initialize_from_response(weathers.first)
    weather
  end

  def get_one_day_forecast(city_key)
    uri = URI("#{BASE_URL}/#{ONE_DAILY_FORECAST_ENDPOINT % [city_key, @api_key, @language]}")
    response = Net::HTTP.get_response(uri)
    json = response.body
    weathers = JSON.parse(json)
    forecast = DailyForecast.new
    forecast.initialize_from_response(weathers["DailyForecasts"].first)
    forecast
  end

  def get_one_hour_forecast(city_key)
    uri = URI("#{BASE_URL}/#{ONE_HOUR_FORECASTS_ENDPOINT % [city_key, @api_key, @language]}")
    response = Net::HTTP.get_response(uri)
    json = response.body
    weathers = JSON.parse(json)
    weather = HourlyWeather.new
    weather.initialize_from_response(weathers.first)
    weather
  end

  def get_twelve_hours_forecast(city_key)
    uri = URI("#{BASE_URL}/#{TWELVE_HOURS_FORECASTS_ENDPOINT % [city_key, @api_key, @language]}")
    response = Net::HTTP.get_response(uri)
    json = response.body
    weathers = JSON.parse(json)
    weathers.map! do |w|
      weather = HourlyWeather.new
      weather.initialize_from_response(w)
      weather
    end
    weathers
  end

  def get_five_daily_forecasts(city_key)
    uri = URI("#{BASE_URL}/#{FIVE_DAILY_FORECASTS_ENDPOINT % [city_key, @api_key, @language]}")
    response = Net::HTTP.get_response(uri)
    json = response.body
    weathers = JSON.parse(json)
    daily_forecasts = []
    weathers["DailyForecasts"].each do |fr|
      daily_forecast = DailyForecast.new
      daily_forecast.initialize_from_response(fr)

      daily_forecasts << daily_forecast
    end
    daily_forecasts
  end
end
