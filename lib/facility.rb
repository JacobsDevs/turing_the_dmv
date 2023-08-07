class Facility
  attr_reader :name,
              :address,
              :phone,
              :services

  def initialize(facility_information)
    @name = facility_information[:name]
    @address = facility_information[:address]
    @phone = facility_information[:phone]
    @services = []
  end

  def add_service(service)
    @services << service
  end
end
