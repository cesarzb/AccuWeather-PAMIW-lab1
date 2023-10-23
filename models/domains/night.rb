class Night
  attr_accessor :icon_phrase

  def initialize_from_response(night)
    @icon_phrase = night["IconPhrase"]
  end
end
