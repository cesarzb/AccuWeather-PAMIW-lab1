require 'tk'
require './weather_service'
require './response_serializer'

root = TkRoot.new { title 'AccuWeather Forecast' }
root.state('zoomed')
Tk.update

def update_city_list
  location_name = @location_entry.get
  cities = @accu_weather_service.get_locations(location_name)
  @city_list.delete(0, 'end')

  cities.each do |city|
    @city_list.insert('end', "#{city['LocalizedName']} (Key: #{city['Key']})")
  end
end

def update_options_list
  @options_list.delete(0, 'end')
  options = [
    {number: 1, name: "Current conditions" },
    {number: 2, name: "One day forecast" },
    {number: 3, name: "One hour forecast" },
    {number: 4, name: "Twelve hourly forecasts" },
    {number: 5, name: "Five daily forecasts" },
  ]

  options.each do |option|
    @options_list.insert('end', "#{option[:number]}: #{option[:name]}")
  end
end

def get_weather
  puts "selected option: #{@selected_option}"
  selected_city = @city_list.get(@city_list.curselection[0])
  city_key = selected_city[/\(Key: (\d+)\)/, 1]
  option_number = @selected_option[/(\d+):/, 1]
  puts "Option number: #{option_number}"
  case option_number.to_i
    when 1
      current_conditions_handler(city_key)
    when 2
      one_day_forecast_handler(city_key)
    when 3
      one_hour_forecast_handler(city_key)
    when 4
      twelve_hours_forecast_handler(city_key)
    when 5
      five_daily_forecasts_handler(city_key)
  end
end

def update_selected_option
  @selected_option = @options_list.get(@options_list.curselection[0])
  puts "selection updated to: #{@selected_option}"
end

@accu_weather_service = AccuWeatherService.new

location_frame = TkFrame.new(root).pack
TkLabel.new(location_frame) { text 'Enter Location: ' }.pack(side: 'left')
@location_entry = TkEntry.new(location_frame).pack(side: 'left')
search_button = TkButton.new(location_frame) { text 'Search' }.pack(side: 'left')
search_button.command { update_city_list }

@selected_option = "1: Current conditions"
@options_list = TkListbox.new(root).pack
@options_list.bind('ButtonRelease-1') { update_selected_option }
update_options_list

@city_list = TkListbox.new(root).pack
@city_list.bind('ButtonRelease-1') { get_weather }

@weather_label = TkText.new(@weather_frame) do
  wrap 'none'  # To ensure horizontal scrolling
  width 60     # Adjust the width as needed
  height 10    # Adjust the height as needed
  yscrollcommand(proc { |first, last| @scrollbar.set(first, last) })
end.pack(side: 'left', fill: 'both', expand: 'yes')

@scrollbar = TkScrollbar.new(@weather_frame) do
  orient 'vertical'
  command(proc { |*args| @weather_label.yview(*args) })
end.pack(side: 'right', fill: 'y')
@weather_label.yscrollcommand(proc { |first, last| @scrollbar.set(first, last) })

# Scrollbar and label configuration to enable scrolling
@scrollbar.command(proc { |*args| @weather_label.yview(*args) })
@weather_label.yscrollcommand(proc { |first, last| @scrollbar.set(first, last) })


Tk.mainloop
