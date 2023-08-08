require 'spec_helper'

RSpec.describe FacilityFactory do
  before(:each) do
	  @factory = FacilityFactory.new
		@colorado_facilities = DmvDataService.new.co_dmv_office_locations
	end
	describe '#initialize' do
		it 'can initialize' do
			expect(@factory).to be_an_instance_of(FacilityFactory)
		end
		it 'initializes with an empty list of factories' do
		  expect(@factory.factory_list).to eq([])
	  end
	end
  describe '#create_facilities' do
		it 'fills factory_list with Factory objects for Colorado format' do
			factory.create_facilities(@colorado_facilities)
			expect(@factory.factory_list[0]).to be_an_instance_of(Facility)
		end
	end
end