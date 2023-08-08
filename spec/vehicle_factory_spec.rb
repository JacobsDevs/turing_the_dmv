require 'spec_helper'

RSpec.describe VehicleFactory
  describe '#initialize' do
	  it 'can initialize' do
		  factory = VehicleFactory.new
			expect(factory).to be_an_instance_of VehicleFactory
		end
	end
end