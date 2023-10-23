require './models/domains/country'
require './models/domains/administrative_area'

class City
  attr_accessor :version, :key, :type, :rank, :localized_name,
    :country, :administrative_area

  def initialize_from_response(c)
    administrative_area = AdministrativeArea.new
    administrative_area.initialize_from_response(c)
    country = Country.new
    country.initialize_from_response(c)
    @version = c["Version"]
    @key = c["Key"]
    @type = c["Type"]
    @rank = c["Rank"]
    @localized_name = c["LocalizedName"]
    @country = country
    @administrative_area = administrative_area
  end
end
