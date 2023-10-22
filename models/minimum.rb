class Minimum
  attr_accessor :value, :unit, :unit_type

  def initialize_from_response(minimum)
    @value = minimum["Value"]
    @unit = minimum["Unit"]
    @unit_type = minimum["UnitType"]
  end
end
