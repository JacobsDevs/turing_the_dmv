class Registrant
  attr_reader :name,
              :age,
              :permit

  attr_accessor :license_data

	def initialize(name, age, permit= false, license_data= {written: false, license: false, renewed: false})
		@name = name
		@age = age
		@permit = permit
		@license_data = license_data
	end

	def permit?
		return @permit
	end

	def earn_permit
		@permit = true
	end

	def eligible_for_permit?
		age >= 16
	end
end