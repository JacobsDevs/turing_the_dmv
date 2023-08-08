require 'facility'

class FacilityFactory
  attr_reader :factory_list

	def initialize
	  @factory_list = []
	end

  def create_facilities(dataset)
		dataset.each do |data|
			data = format_data(data)
			@factory_list << Facility.new(data)
		end
		p @factory_list
	end

  def format_data(data)
    data[:name] = format_name(data)
    data[:services] = format_services(data)
		return data
	end

	def format_name(data)
	  name = data[:dmv_office]
	end

	def format_services(data)
		services = data[:services_p].split(",")
	  formatted_services = services.map do |service|
      "Vehicle Registration" if services == "registration"
		end
		return formatted_services
	end
end