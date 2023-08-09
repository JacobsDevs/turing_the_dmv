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
		it 'read data from data set and sends it to #format_data' do
			expect(@factory.create_facilities(@colorado_facilities)[0][:name]).to eq("DMV Tremont Branch, CO")
		end
	end
	describe '#format_data' do
		it 'sends data to #format_name' do
		  expect(@factory.format_data({:dmv_office=>"DMV Test", :state=>"CO"})[:name]).to eq("DMV Test, CO")
		end
		it 'sends data to #format_address'
		it 'sends data to #format_phone'
		it 'sends data to #format_services'
	end
	describe '#format_name' do
		it 'returns string in the format "DMV *LOCATION*, *STATE*"' do
		  expect(@factory.format_name({:dmv_office=>"DMV Test", :state=> "CO"})).to eq("DMV Test, CO")
		end
	end
	describe '#format_address' do
		it 'returns data in the format "#### Street, Suite ###, City, STATE, zip"'
	end
	describe '#format_phone' do
		it 'returns data in the format "(###) ###-####"'
	end
	describe '#format_services' do
		it 'returns an array with valid services'
	end
end