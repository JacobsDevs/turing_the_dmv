require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )

	end

  describe '#initialize' do
    it 'can initialize' do
      expect(@facility1).to be_an_instance_of(Facility)
      expect(@facility1.name).to eq('DMV Tremont Branch')
      expect(@facility1.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility1.phone).to eq('(720) 865-4600')
      expect(@facility1.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility1.services).to eq([])
      @facility1.add_service('New Drivers License')
      @facility1.add_service('Renew Drivers License')
      @facility1.add_service('Vehicle Registration')
      expect(@facility1.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#register_vehicle' do
    it 'can register a vehicle to a facility with "Vehicle Registration" service' do
      @facility1.add_service('Vehicle Registration')
      @facility1.register_vehicle(@cruz)
      expect(@facility1.registered_vehicles).to eq([@cruz])
    end
    it 'can not register at a facility without "Vehicle Registration" service' do
      @facility2.register_vehicle(@cruz)
      expect(@facility2.registered_vehicles).to eq([])
    end
  end

	describe '#collect_fee' do
	  it 'charges the correct fee for the registered vehicle' do
		  @facility1.add_service('Vehicle Registration')
			@facility1.register_vehicle(@cruz)
			expect(@facility1.collected_fees).to eq(100)
			
			@facility1.register_vehicle(@camaro)
			expect(@facility1.collected_fees).to eq(125)
			
			@facility1.register_vehicle(@bolt)
			expect(@facility1.collected_fees).to eq(325)
		end
	end

	describe '#issue_plate' do
		it 'issues a plate_type to car based on engine and antique status' do
      @facility1.add_service('Vehicle Registration')
			@facility1.register_vehicle(@cruz)
			expect(@cruz.plate_type).to eq(:ice)
			@facility1.register_vehicle(@camaro)
			expect(@camaro.plate_type).to eq(:antique)
			@facility1.register_vehicle(@bolt)
			expect(@bolt.plate_type).to eq(:ev)
		end
	end
end
