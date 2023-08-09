require 'facility'

class FacilityFactory
  attr_reader :facility_list

	def initialize
	  @facility_list = []
	end

	def create_facilities(dataset)
		dataset.each do |data|
			@facility_list << Facility.new(format_data(data))
		end
	end

	def format_data(data)
		data[:name] = format_name(data)
		data[:address] = format_address(data)
		data[:services] = format_services(data)
		data[:phone] = format_phone(data)
		return data
	end

	def format_name(data)
	  if data[:state] == "CO"
		  data[:dmv_office] + ", " + data[:state]
		elsif data[:state] == "NY"
			"DMV #{titlecase(data[:office_name])} #{titlecase(data[:office_type])}, #{data[:state]}" if data[:state] == "NY"
		end
	end

	def titlecase(string)
	  string.split(" ").map {|word| word.downcase.capitalize.chomp}.join(" ")
	end

	def format_address(data)
    data[:address_li] + ", " + 
		(data[:address__1].nil? ? "" : data[:address__1] + ", ") +
		(data[:location].nil? ? "" : data[:location] + ", ") + 
		data[:city] + ", " + 
		data[:state] + ", " + 
		data[:zip]
	end

	def format_phone(data)
		raw = data[:phone].gsub(/\D/, '')
		number = "(#{raw[0..2]}) #{raw[3..5]}-#{raw[6..9]}"
	end

	def format_services(data)
		services = data[:services_p].split(/[,;]/).map do |service|
			service.strip!
			if service == "vehicle titles"
				"Vehicle Titles"
			elsif service == "registration"
				"Vehicle Registration"
			elsif service == "renewals"
				"Renew License"
			else service
			end
		end
		return services
	end
end