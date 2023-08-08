require 'vehicle'

class VehicleFactory
  attr_reader :vehicle_list

  def initialize
		@vehicle_list = []
	end

  def create_vehicles(data_source)
		data_source.each do |data|
			data[:vin] = data[:vin_1_10]
			vehicle = Vehicle.new(data)
			@vehicle_list << vehicle
		end
	end
end