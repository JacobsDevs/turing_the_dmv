require 'spec_helper'

RSpec.describe VehicleFactory do
  describe '#initialize' do
	  it 'can initialize' do
		  factory = VehicleFactory.new
			expect(factory).to be_an_instance_of(VehicleFactory)
		end
	end

	describe '#create_vehicles' do
		before(:each)  do
			@factory = VehicleFactory.new
			@wa_ev_registrations = DmvDataService.new.wa_ev_registrations
		end
		it 'puts a vehicle into factory.vehicle_list' do
		  @factory.create_vehicles(@wa_ev_registrations)
			p @factory.vehicle_list
			expect(@factory.vehicle_list[0]).to be_an_instance_of(Vehicle)
		end
	end
end