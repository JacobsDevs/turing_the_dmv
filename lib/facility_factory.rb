class FacilityFactory
  attr_reader :factory_list

	def initialize
	  @factory_list = []
	end

  def create_facilities(dataset)
		dataset.each do |data|
			data = format_data(data)
		end
	end

  def format_data(data)
    data[:name] = format_name(data)
    data[:services] = format_services(data)
		return data
	end

	def format_name(data)
	  name = data[:dmv_office]
	end
end