require 'spec_helper'

RSpec.describe FacilityFactory do
  before(:each) do
	  @factory = FacilityFactory.new
		@colorado_facilities = DmvDataService.new.co_dmv_office_locations
		@new_york_facilities = DmvDataService.new.ny_dmv_office_locations
		@missouri_facilities = DmvDataService.new.mo_dmv_office_locations
		@test_object_colorado = {:the_geom=>{:type=>"Point", :coordinates=>[-104.97443112500002, 39.75525297420336]}, :dmv_id=>"1", :dmv_office=>"DMV Tremont Branch", :address_li=>"2855 Tremont Place", :address__1=>"Suite 118", :city=>"Denver", :state=>"CO", :zip=>"80205", :phone=>"(720)) 8654600", :hours=>"Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.", :services_p=>"vehicle titles, registration, renewals;  VIN inspections", :parking_no=>"parking available in the lot at the back of the bldg (Glenarm Street)", :photo=>"images/Tremont.jpg", :address_id=>"175164", :":@computed_region_nku6_53ud"=>"1444"}
	  @test_object_new_york = {:office_name=>"JAMAICA", :office_type=>"DISTRICT OFFICE", :public_phone_number=>"7189666155", :street_address_line_1=>"168-46 91ST AVE., 2ND FLR", :city=>"JAMAICA", :state=>"NY", :zip_code=>"11432", :monday_beginning_hours=>"7:30 AM", :monday_ending_hours=>"5:00 PM", :tuesday_beginning_hours=>"7:30 AM", :tuesday_ending_hours=>"5:00 PM", :wednesday_beginning_hours=>"7:30 AM", :wednesday_ending_hours=>"5:00 PM", :thursday_beginning_hours=>"7:30 AM", :thursday_ending_hours=>"5:00 PM", :friday_beginning_hours=>"7:30 AM", :friday_ending_hours=>"5:00 PM", :georeference=>{:type=>"Point", :coordinates=>[-73.791443647, 40.707575521]}, :":@computed_region_yamh_8v7k"=>"196", :":@computed_region_wbg7_3whc"=>"1216", :":@computed_region_kjdx_g34t"=>"2137"}
    @test_object_missouri	= {:number=>"166", :dorregionnumber=>"8", :type=>"1MV", :name=>"OAKVILLE", :address1=>"3164 TELEGRAPH ROAD", :city=>"ST LOUIS", :state=>"MO", :zipcode=>"63125", :county=>"St. Louis County", :phone=>"(314) 887-1050", :fax=>"(314) 887-1051", :size=>"3", :email=>"OAKVILLEAGENTOFFICE@DOR.MO.GOV", :agent=>"York Management Group, LLC.", :officemanager=>"Rita Lahr", :daysopen=>"Monday-Friday - 9:00 to 5:00, Last Saturday  - 9:00 to 12:00", :holidaysclosed=>"Thanksgiving (11/24/22), Christmas Day Observed (12/26/22), New Year's Day Observed (01/02/23), Martin Luther King Day (01/16/23), President's Day (02/20/23), Memorial Day (05/29/23), Juneteenth (06/19/2023), Independence Day (07/04/23), Labor Day (09/04/23), Veterans Day (11/10/23), Thanksgiving (11/23/23), Christmas Day Observed (12/25/23)", :additionaldaysclosed=>"7/2/22,      9/3/22,      11/25/22,      11/26/22,      11/28/2022 (at 11:45 AM),      12/22/2022 (at 1:30 PM ),      12/31/22,     1/25/2023 (at 9:00 AM until 11:00 AM),  1/25/2023 (open at 11:00 AM),  1/30/2023 (at 9:00 AM until 10:00 AM),  1/30/2023 (open at 10:00 AM),  2/22/2023 (at 3:00 PM),  5/27/23,  07/03/2023,  7/31/2023 (at 12:45 PM ),  9/2/23,  11/24/23,  11/25/23,  12/30/23", :latlng=>{:latitude=>"38.4981572", :longitude=>"-90.3001675"}, :facebook_url=>"https://m.facebook.com/people/Oakville-License-Office/100069096876261/", :textingphonenumber=>"(314) 730-0606", :othercontactinfo=>"Public Email: oakville@yorkmanagementgroup.com", :":@computed_region_ny2h_ckbz"=>"248", :":@computed_region_c8ar_jsdj"=>"51", :":@computed_region_ikxf_gfzr"=>"2210"}
	end
	describe '#initialize' do
		it 'can initialize' do
			expect(@factory).to be_an_instance_of(FacilityFactory)
		end
		it 'initializes with an empty list of factories' do
		  expect(@factory.facility_list).to eq([])
	  end
	end
	describe '#create_facilities' do
		it 'returns a list of facility objects for CO facilities' do
		  @factory.create_facilities(@colorado_facilities)
			expect(@factory.facility_list[0]).to be_an_instance_of Facility
		end
		it 'returns a list of facility objects for NY facilities' do
		  @factory.create_facilities(@new_york_facilities)
			expect(@factory.facility_list[0]).to be_an_instance_of Facility
		end
		it 'returns a list of facility objects for MO facilities' do
		  @factory.create_facilities(@missouri_facilities)
			expect(@factory.facility_list[0]).to be_an_instance_of Facility
		end
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
		it 'returns string in the format "DMV *LOCATION*, *STATE*" for CO' do
		  expect(@factory.format_name(@test_object_colorado)).to eq("DMV Tremont Branch, CO")
		end
		it 'returns string in the format "DMV *LOCATION*, *STATE*" for NY' do
		  expect(@factory.format_name(@test_object_new_york)).to eq("DMV Jamaica District Office, NY")
		end
		it 'returns string in the format "DMV *LOCATION*, *STATE*" for MO' do
		  expect(@factory.format_name(@test_object_missouri)).to eq("DMV Oakville Branch, MO")
		end
	end
	describe '#titlecase' do
		it 'returns a string with the first letter of each word capitalized' do
			expect(@factory.titlecase("THIS IS A CAPS STRING")).to eq("This Is A Caps String")
		end
	end
	describe '#format_address' do
		# an optional address element is denoted by *element
		it 'returns data in the format "#### Street, *Suite ###, *Location, City, STATE, zip" for CO' do
		  expect(@factory.format_address(@test_object_colorado)).to eq("2855 Tremont Place, Suite 118, Denver, CO, 80205")
	  end
		it 'returns data in the format "#### Street, *Suite ###, *Location, City, STATE, zip" for NY' do
		  expect(@factory.format_address(@test_object_new_york)).to eq("168-46 91st Ave., 2nd Flr, Jamaica, NY, 11432")
	  end
		it 'returns data in the format "#### Street, *Suite ###, *Location, City, STATE, zip" for MO' do
		  expect(@factory.format_address(@test_object_missouri)).to eq("3164 Telegraph Road, St Louis, MO, 63125")
	  end
	end
	describe '#format_phone' do
		it 'returns data in the format "(###) ###-####" for CO' do
			expect(@factory.format_phone(@test_object_colorado)).to eq("(720) 865-4600")
		end
		it 'returns data in the format "(###) ###-####" for NY' do
		  expect(@factory.format_phone(@test_object_new_york)).to eq("(718) 966-6155")
		end
		it 'returns data in the format "(###) ###-####" for MO' do
		  expect(@factory.format_phone(@test_object_missouri)).to eq("(314) 887-1050")
		end
	end
	describe '#format_services' do
		it 'returns an array with valid services for CO' do
			expect(@factory.format_services(@test_object_colorado)).to eq(["Vehicle Titles", "Vehicle Registration", "Renew License", "VIN inspections"])
		end
		it 'returns an array with valid services for NY' do
			expect(@factory.format_services(@test_object_new_york)).to eq([])
		end
	end
end