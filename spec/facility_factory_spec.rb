require 'spec_helper'

RSpec.describe FacilityFactory do
  before(:each) do
	  @factory = FacilityFactory.new
		@colorado_facilities = DmvDataService.new.co_dmv_office_locations
		@test_object = {:the_geom=>{:type=>"Point", :coordinates=>[-104.97443112500002, 39.75525297420336]}, :dmv_id=>"1", :dmv_office=>"DMV Tremont Branch", :address_li=>"2855 Tremont Place", :address__1=>"Suite 118", :city=>"Denver", :state=>"CO", :zip=>"80205", :phone=>"(720) 865-4600", :hours=>"Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.", :services_p=>"vehicle titles, registration, renewals;  VIN inspections", :parking_no=>"parking available in the lot at the back of the bldg (Glenarm Street)", :photo=>"images/Tremont.jpg", :address_id=>"175164", :":@computed_region_nku6_53ud"=>"1444"}
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
		it ''
	end
	describe '#format_data' do
		it 'returns a hash with valid :name, :address & :services for use with #create_facilities' do
			formatted = @factory.create_facilities(@colorado_facilities)
			expect(formatted[0][:name]).to eq("DMV Tremont Branch, CO")
			expect(formatted[4][:address]).to eq("2243 S Monaco Street Pkwy, Villa Monaco, Denver, CO, 80222")
			expect(formatted[0][:services]).to eq(["Vehicle Titles", "Vehicle Registration", "Renew License", "VIN inspections"])
		end
	end
	describe '#format_name' do
		it 'returns string in the format "DMV *LOCATION*, *STATE*"' do
		  expect(@factory.format_name(@test_object)).to eq("DMV Tremont Branch, CO")
		end
	end
	describe '#format_address' do
		# an optional address element is denoted by *element
		it 'returns data in the format "#### Street, *Suite ###, *Location, City, STATE, zip"' do
		  expect(@factory.format_address(@test_object)).to eq("2855 Tremont Place, Suite 118, Denver, CO, 80205")
	  end
	end
	describe '#format_phone' do
		it 'returns data in the format "(###) ###-####"'
	end
	describe '#format_services' do
		it 'returns an array with valid services' do
			expect(@factory.format_services(@test_object)).to eq(["Vehicle Titles", "Vehicle Registration", "Renew License", "VIN inspections"])
		end
	end
end