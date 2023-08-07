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
    return unless @services.include?('Vehicle Registration')

    @collected_fees += collect_fee(vehicle)
    @registered_vehicles << vehicle
    vehicle.plate_type = issue_plate(vehicle)
  end

  def collect_fee(vehicle)
    return 25 if vehicle.antique?

    vehicle.electric_vehicle? ? 200 : 100
  end

  def issue_plate(vehicle)
    return :antique if vehicle.antique?

    vehicle.electric_vehicle? ? :ev : :ice
  end

  def administer_written_test(registrant)
    return false unless @services.include?('Written Test') && registrant.permit? == true

    registrant.license_data[:written] = registrant.eligible_for_permit?
  end
end
