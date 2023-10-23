require './models/weather_fetch'
require './view_models/serializers/response_serializer'

class ViewModel
  def initialize()
    @accu_weather_service = AccuWeatherService.new
  end

  def update_city_list(location_entry, city_list)
    location_name = location_entry.get
    cities = @accu_weather_service.get_locations(location_name)
    city_list.delete(0, 'end')
    cities.each do |city|
      city_list.insert('end', "#{city.localized_name} (Key: #{city.key})")
    end
  end

  def update_options_list(options_list)
    options_list.delete(0, 'end')
    options = [
      {number: 1, name: "Current conditions" },
      {number: 2, name: "One day forecast" },
      {number: 3, name: "One hour forecast" },
      {number: 4, name: "Twelve hourly forecasts" },
      {number: 5, name: "Five daily forecasts" },
    ]

    options.each do |option|
      options_list.insert('end', "#{option[:number]}: #{option[:name]}")
    end
  end

  def update_selected_option(selected_option, options_list)
    selected_option = options_list.get(options_list.curselection[0])
      puts "selection updated to: #{selected_option}"
    selected_option
  end
  def get_weather(selected_option, city_list, weather_label)
    puts "selected option: #{selected_option}"
    selected_city = city_list.get(city_list.curselection[0])
    city_key = selected_city[/\(Key: (\d+)\)/, 1]
    option_number = selected_option[/(\d+):/, 1]
    puts "Option number: #{option_number}"
    # weather_label.insert('1.0', '')
    weather_label.delete('1.0', 'end')
    label = ''
    case option_number.to_i
      when 1
        label = current_conditions_handler(city_key)
      when 2
        label = one_day_forecast_handler(city_key)
      when 3
        label = one_hour_forecast_handler(city_key)
      when 4
        label = twelve_hours_forecast_handler(city_key)
      when 5
        label = five_daily_forecasts_handler(city_key)
    end
    weather_label.insert('1.0', "\n#{label}\n")
  end
end
