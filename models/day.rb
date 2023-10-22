class Day
  attr_accessor :icon_phrase

  def initialize_from_response(day)
    @icon_phrase = day["IconPhrase"]
  end
end
