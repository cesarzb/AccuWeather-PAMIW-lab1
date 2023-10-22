def current_conditions_handler(city_key)
  weather = @accu_weather_service.get_current_conditions(city_key)
  text = ""
  if weather
    text = "Current Conditions: #{weather.weather_text}, Temperature: #{weather.temperature.metric.value}°C"
  else
    text = 'No weather data found for the selected city.'
  end
end

def one_day_forecast_handler(city_key)
  weather = @accu_weather_service.get_one_day_forecast(city_key)
  text = ""
  if weather
    text = "Day: #{weather.day.icon_phrase}\n
    Night: #{weather.night.icon_phrase}\n
    Minimal Temperature: #{weather.temperature.minimum.value}°C\n
    Maximal Temperature: #{weather.temperature.maximum.value}°C"
  else
    text = 'No weather data found for the selected city.'
  end
end

def one_hour_forecast_handler(city_key)
  weather = @accu_weather_service.get_one_hour_forecast(city_key)
  text = ""
  if weather
    text = "Current Conditions: #{weather.icon_phrase}\n
    Temperature: #{weather.temperature.value}°C\n"
  else
    text = 'No weather data found for the selected city.'
  end
end

def twelve_hours_forecast_handler(city_key)
  weathers = @accu_weather_service.get_twelve_hours_forecast(city_key)
  text = ""
  weathers.each do |weather|
    if weather
      text += "\n---\n"
      text += "Current Conditions: #{weather.icon_phrase}\nTemperature: #{weather.temperature.value}°C\n\n"
    else
      text += 'No weather data found for the selected city, for this hour.'
    end
    if !weathers
      text = 'No weather data found for the selected city.'
    end
  end
  text
end

def five_daily_forecasts_handler(city_key)
  daily_forecasts = @accu_weather_service.get_five_daily_forecasts(city_key)
  text = ""
  daily_forecasts.each do |forecast|
    if forecast
      text += "\n---\n"
      text += "Day: #{forecast.day.icon_phrase}\n
    Night: #{forecast.night.icon_phrase}\n
    Minimal Temperature: #{forecast.temperature.minimum.value}°C\n
    Maximal Temperature: #{forecast.temperature.maximum.value}°C\n\n"
    else
      text += 'No weather data found for the selected city, for this day.'
    end
    if !daily_forecasts
      text = 'No weather data found for the selected city.'
    end
  end
  text
end
