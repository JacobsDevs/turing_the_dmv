require 'spec_helper'

RSpec.describe Registrant do
  before(:each) do
    @registrant_1 = Registrant.new('Bruce', 18, true)
		@registrant_2 = Registrant.new('Penny', 15)
	end

	describe '#initialize' do
		it 'can initialize' do
      expect(@registrant_1).to be_an_instance_of Registrant
			expect(@registrant_1.name).to eq('Bruce')
			expect(@registrant_1.age).to eq(18)
      expect(@registrant_1.permit).to eq(true)
		end
		it 'can initialize with correct default information' do
		  expect(@registrant_2.permit).to eq(false)
			expect(@registrant_2.license_data).to eq({:written=> false, :license=>false, :renewed=>false})
		end
  end

	describe '#permit?' do
		it 'returns correct value based on registrant having a permit' do
		  expect(@registrant_1.permit?).to eq(true)
		  expect(@registrant_2.permit?).to eq(false)
		end
	end

	describe '#earn_permit' do
	  it 'updates registrant permit status correctly' do
      @registrant_2.earn_permit
			expect(@registrant_2.permit?).to eq(true)
		end
	end

	describe '#eligible_for_permit?' do
    it 'returns true or false based on applicant age' do
			expect(@registrant_1.eligible_for_permit?).to eq(true)
			expect(@registrant_2.eligible_for_permit?).to eq(false)
		end
	end
end