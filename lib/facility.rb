class Facility
  attr_reader :name,
              :address,
              :phone,
              :services,
							:registered_vehicles,
							:collected_fees

  def initialize(facility_information)
    @name = facility_information[:name]
    @address = facility_information[:address]
    @phone = facility_information[:phone]
    @services = []
		@registered_vehicles = []
		@collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
		@registered_vehicles << vehicle
  end
end
