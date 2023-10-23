class HourlyTemperature
  attr_accessor :value

  def initialize_from_response(hourly_temperature)
    @value = hourly_temperature["Value"]
  end
end
