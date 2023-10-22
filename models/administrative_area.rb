class AdministrativeArea
  attr_accessor :id, :localized_name

  def initialize_from_response(c)
    @id = c["AdministrativeArea"]["Id"]
    @localized_name = c["AdministrativeArea"]["LocalizedName"]
  end
end
