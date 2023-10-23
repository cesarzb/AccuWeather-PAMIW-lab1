require './models/domains/metric'
require './models/domains/imperial'

class Temperature
  attr_accessor :metric, :imperial

  def initialize_from_response(c)
    metric = Metric.new
    metric.initialize_from_response(c)
    imperial = Imperial.new
    imperial.initialize_from_response(c)
    @metric = metric
    @imperial = imperial
  end
end
