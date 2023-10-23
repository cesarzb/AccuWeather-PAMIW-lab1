class Maximum
  attr_accessor :value, :unit, :unit_type

  def initialize_from_response(maximum)
    @value = maximum["Value"]
    @unit = maximum["Unit"]
    @unit_type = maximum["UnitType"]
  end
end
