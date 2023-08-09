require 'spec_helper'

RSpec.describe FacilityFactory do
  before(:each) do
	  @factory = FacilityFactory.new
		@colorado_facilities = DmvDataService.new.co_dmv_office_locations
		@dirty_data = {dmv_office: "DMV Tremont Branch", services_p: "vehicle titles, registration, renewals;", phone: "758-000"}
	  @clean_data = {name: "DMV Tremont Branch", services: ["vehicle titles", "Vehicle Registration", "Renew License"], phone: "758-000"}
	  @facility = Facility.new(@clean_data)
	end
	describe '#initialize' do
		it 'can initialize' do
			expect(@factory).to be_an_instance_of(FacilityFactory)
		end
		it 'initializes with an empty list of factories' do
		  expect(@factory.factory_list).to eq([])
	  end
	end
  
end