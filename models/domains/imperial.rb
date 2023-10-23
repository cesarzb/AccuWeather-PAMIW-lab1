class Imperial
  attr_accessor :value, :unit, :unit_type

  def initialize_from_response(c)
    @value = c["Temperature"]["Imperial"]["Value"]
    @unit = c["Temperature"]["Imperial"]["Unit"]
    @unit_type = c["Temperature"]["Imperial"]["UnitType"]
  end
end
