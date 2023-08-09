require 'facility'

class FacilityFactory
  attr_reader :factory_list

	def initialize
	  @factory_list = []
	end

	def create_facilities(dataset)
		dataset.each do |data|
			data = format_data(data)
		end
		dataset
	end

	def format_data(data)
		data[:name] = format_name(data)
		data[:address] = format_address(data)
		data[:services] = format_services(data)
		data[:phone] = format_phone(data)
	end

	def format_name(data)
	  data[:dmv_office] + ", " + data[:state]
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