class Metric
  attr_accessor :value, :unit, :unit_type

  def initialize_from_response(c)
    @value = c["Temperature"]["Metric"]["Value"]
    @unit = c["Temperature"]["Metric"]["Unit"]
    @unit_type = c["Temperature"]["Metric"]["UnitType"]
  end
end
