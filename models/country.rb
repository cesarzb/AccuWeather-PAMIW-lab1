class Country
  attr_accessor :id, :localized_name

  def initialize_from_response(c)
    @id = c["Country"]["Id"]
    @localized_name = c["Country"]["LocalizedName"]
  end
end
