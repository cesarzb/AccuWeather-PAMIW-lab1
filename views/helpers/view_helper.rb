module ViewHelperModule
  def update_city
    @view_model.update_city_list(@location_entry, @city_list)
  end

  def get_weather
    @view_model.get_weather(@selected_option, @city_list, @weather_label)
  end

  def update_selected
    @selected_option = @view_model.update_selected_option(@selected_option, @options_list)
  end
end
