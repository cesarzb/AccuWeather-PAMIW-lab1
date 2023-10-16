def current_conditions_handler(city_key)
  weather = @accu_weather_service.get_current_conditions(city_key)
  text = ""
  @weather_label.insert('1.0', '')
  if weather
    text = "Current Conditions: #{weather['WeatherText']}, Temperature: #{weather['Temperature']['Metric']['Value']}°C"
  else
    text = 'No weather data found for the selected city.'
  end
  @weather_label.insert('1.0', text)
end

def one_day_forecast_handler(city_key)
  weather = @accu_weather_service.get_one_day_forecast(city_key)
  text = ""
  @weather_label.insert('1.0', '')
  if weather
    text = "Day: #{weather['Day']['IconPhrase']}\n
    Night: #{weather['Night']['IconPhrase']}\n
    Minimal Temperature: #{weather['Temperature']['Minimum']['Value']}°C\n
    Maximal Temperature: #{weather['Temperature']['Maximum']['Value']}°C"
  else
    text = 'No weather data found for the selected city.'
  end
  @weather_label.insert('1.0', text)
end

def one_hour_forecast_handler(city_key)
  weather = @accu_weather_service.get_one_hour_forecast(city_key)
  text = ""
  @weather_label.insert('1.0', '')
  if weather
    text = "Current Conditions: #{weather['IconPhrase']}\n
    Temperature: #{weather['Temperature']['Value']}°C"
  else
    text = 'No weather data found for the selected city.'
  end
  @weather_label.insert('1.0', text)
end

def twelve_hours_forecast_handler(city_key)
  weathers = @accu_weather_service.get_twelve_hours_forecast(city_key)
  text = ""
  @weather_label.insert('1.0', '')
  weathers.each do |weather|
    if weather
      text += "\n---\n"
      text += "Current Conditions: #{weather['IconPhrase']}\nTemperature: #{weather['Temperature']['Value']}°C\n\n"
    else
      text += 'No weather data found for the selected city, for this hour.'
    end
    if !weathers
      text = 'No weather data found for the selected city.'
    end
  end
  @weather_label.insert('1.0', text)
end

def five_daily_forecasts_handler(city_key)
  weathers = @accu_weather_service.get_five_daily_forecasts(city_key)
  text = ""
  @weather_label.insert('1.0', '')
  weathers.each do |weather|
    if weather
      text += "\n---\n"
      text += "Day: #{weather['Day']['IconPhrase']}\n
    Night: #{weather['Night']['IconPhrase']}\n
    Minimal Temperature: #{weather['Temperature']['Minimum']['Value']}°C\n
    Maximal Temperature: #{weather['Temperature']['Maximum']['Value']}°C\n\n"
    else
      text += 'No weather data found for the selected city, for this day.'
    end
    if !weathers
      text = 'No weather data found for the selected city.'
    end
  end
  @weather_label.insert('1.0', text)
end
