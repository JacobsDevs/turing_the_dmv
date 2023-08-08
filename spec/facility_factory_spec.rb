require 'spec_helper'

RSpec.describe FacilityFactory do
  before(:each) do
	  @factory = FacilityFactory.new
		@colorado_facilities = DmvDataService.new.co_dmv_office_locations
		@dirty_data = {dmv_office: "DMV Tremont Branch", services_p: "vehicle titles, registration, renewals; VIN inspections"}
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
			@factory.create_facilities(@colorado_facilities)
			expect(@factory.factory_list[0]).to be_an_instance_of(Facility)
		end
	end
	describe '#format_data' do
	  it 'returns formatted data for use with the Facility class' do
		  @factory.format_data(@dirty_data)
			expect()
		end
	end
	describe '#format_name' do
		it 'returns a formatted name for use with the Facility class' do
		  expect(@factory.format_name())
		end
	end
	describe '#format_services' do
		it 'returns a formatted array of services for use with the Facility class' do
		  expect(@factory.format_services(["renewals; license"])).to eq(["Renew License"])
		end
	end
end