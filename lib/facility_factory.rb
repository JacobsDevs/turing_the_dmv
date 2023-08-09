require 'facility'

class FacilityFactory
  attr_reader :factory_list

	def initialize
	  @factory_list = []
	end

	def create_facilities(dataset)
		dataset.each do |data|
			data = format_data(data)
			p data[:name]
		end
		dataset
	end

	def format_data(data)
		data[:name] = format_name(data)
		data
	end

	def format_name(data)
	  string = data[:dmv_office] + ", " + data[:state]
	end
end