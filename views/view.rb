require 'tk'
require './view_models/view_model'
require './views/helpers/view_helper'
include ViewHelperModule

class View
  def initialize(view_model)
    @view_model = view_model
    @root = TkRoot.new { title 'AccuWeather Forecast' }
    @root.state('zoomed')
    Tk.update

    create_ui_elements
  end

  def create_ui_elements
    location_frame = TkFrame.new(@root).pack
    TkLabel.new(location_frame) { text 'Enter Location: ' }.pack(side: 'left')
    @location_entry = TkEntry.new(location_frame).pack(side: 'left')
    search_button = TkButton.new(location_frame) { text 'Search' }.pack(side: 'left')

    @selected_option = "1: Current conditions"
    @options_list = TkListbox.new(@root).pack
    @options_list.bind('ButtonRelease-1') { update_selected }
    @city_list = TkListbox.new(@root).pack
    @weather_frame = TkFrame.new(@root).pack
    @weather_label = TkText.new(@weather_frame) do
      wrap 'none'
      width 60
      height 10
      yscrollcommand(proc { |first, last| @scrollbar.set(first, last) })
    end.pack(side: 'left', fill: 'both', expand: 'yes')
    @view_model.update_options_list(@options_list)
    search_button.command { update_city }

    @city_list.bind('ButtonRelease-1') { get_weather }

    @scrollbar = TkScrollbar.new(@weather_frame) do
      orient 'vertical'
      command(proc { |*args| @weather_label.yview(*args) })
    end.pack(side: 'right', fill: 'y')
    @weather_label.yscrollcommand(proc { |first, last| @scrollbar.set(first, last) })

    @scrollbar.command(proc { |*args| @weather_label.yview(*args) })
  end
end
