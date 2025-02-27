require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@facility_1).to be_an_instance_of(Facility)
      expect(@facility_1.name).to eq('DMV Tremont Branch')
      expect(@facility_1.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility_1.phone).to eq('(720) 865-4600')
      expect(@facility_1.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility_1.services).to eq([])
      @facility_1.add_service('New Drivers License')
      @facility_1.add_service('Renew Drivers License')
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#register_vehicle' do
    it 'can register a vehicle to a facility with "Vehicle Registration" service' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      expect(@facility_1.registered_vehicles).to eq([@cruz])
    end
    it 'can not register at a facility without "Vehicle Registration" service' do
      @facility_2.register_vehicle(@cruz)
      expect(@facility_2.registered_vehicles).to eq([])
    end
  end

  describe '#collect_fee' do
    it 'charges the correct fee for the registered vehicle' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      expect(@facility_1.collected_fees).to eq(100)

      @facility_1.register_vehicle(@camaro)
      expect(@facility_1.collected_fees).to eq(125)

      @facility_1.register_vehicle(@bolt)
      expect(@facility_1.collected_fees).to eq(325)
    end
  end

  describe '#issue_plate' do
    it 'issues a plate_type to car based on engine and antique status' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      expect(@cruz.plate_type).to eq(:ice)
      @facility_1.register_vehicle(@camaro)
      expect(@camaro.plate_type).to eq(:antique)
      @facility_1.register_vehicle(@bolt)
      expect(@bolt.plate_type).to eq(:ev)
    end
  end

  describe '#administer_written_test' do
    it 'can not issue test at facility missing service "Written Test"' do
		  @registrant_1 = Registrant.new('Bruce', 18, true)
			expect(@facility_1.administer_written_test(@registrant_1)).to eq(false)
			expect(@registrant_1.license_data[:written]).to eq(false)
		end
		it 'issues test at valid facility' do
		  @registrant_1 = Registrant.new('Bruce', 18, true)
			@facility_1.add_service('Written Test')
			expect(@facility_1.administer_written_test(@registrant_1)).to eq(true)
			expect(@registrant_1.license_data[:written]).to eq(true)
		end
		it 'can not issue test at valid facility with registrant under age 16' do
			@registrant_1 = Registrant.new('Tucker', 15)
			@facility_1.add_service('Written Test')
			expect(@facility_1.administer_written_test(@registrant_1)).to eq(false)
			expect(@registrant_1.license_data[:written]).to eq(false)
		end
    it 'can not issue test at valid facility if registrant has no permit' do
		  @registrant_1 = Registrant.new('Tucker', 25, false)
			@facility_1.add_service('Written Test')
			expect(@facility_1.administer_written_test(@registrant_1)).to eq(false)
			expect(@registrant_1.license_data[:written]).to eq(false)
		end
	end

	describe '#administer_road_test' do
    before(:each) do
			@registrant_1 = Registrant.new('Bruce', 18, true)
			@facility_1.add_service('Written Test')
		end
		it 'can not issue test at facility missing service "Road Test"' do
			expect(@facility_1.administer_road_test(@registrant_1)).to eq(false)
			expect(@registrant_1.license_data[:license]).to eq(false)
		end
		it 'issues test at valid facility' do
			@facility_1.administer_written_test(@registrant_1)
			@facility_1.add_service('Road Test')
			expect(@facility_1.administer_road_test(@registrant_1)).to eq(true)
			expect(@registrant_1.license_data[:license]).to eq(true)
		end
    it 'can not issue test at valid facility if registrant has not passed a written test' do
			@facility_1.add_service('Road Test')
			expect(@facility_1.administer_road_test(@registrant_1)).to eq(false)
			expect(@registrant_1.license_data[:license]).to eq(false)
		end
	end

	describe '#renew_drivers_license' do
		before(:each) do
			@registrant_1 = Registrant.new('Bruce', 18, true)
			@facility_1.add_service('Written Test')
			@facility_1.add_service('Road Test')
		end
		it 'can not issue test at facility missing service "Renew License"' do
			expect(@facility_1.renew_drivers_license(@registrant_1)).to eq(false)
			expect(@registrant_1.license_data[:renewed]).to eq(false)
		end
		it 'issues test at valid facility' do
			@facility_1.add_service('Renew License')
			@facility_1.administer_written_test(@registrant_1)
			@facility_1.administer_road_test(@registrant_1)
			expect(@facility_1.renew_drivers_license(@registrant_1)).to eq(true)
			expect(@registrant_1.license_data[:renewed]).to eq(true)
		end
		it 'can not issue test at valid facility if registrant has not passed road test & obtained license' do
      @facility_1.add_service('Renew License')
			expect(@facility_1.renew_drivers_license(@registrant_1)).to eq(false)
			expect(@registrant_1.license_data[:renewed]).to eq(false)
		end
	end
end
