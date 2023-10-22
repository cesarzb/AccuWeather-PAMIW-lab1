require './models/minimum'
require './models/maximum'

class DailyTemperature
  attr_accessor :minimum, :maximum

  def initialize_from_response(temperature)
    minimum = Minimum.new
    minimum.initialize_from_response(temperature["Minimum"])
    @minimum = minimum
    maximum = Maximum.new
    maximum.initialize_from_response(temperature["Maximum"])
    @maximum = maximum
  end
end
