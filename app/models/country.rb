class Country < ActiveRecord::Base
	self.table_name = "COUNTRIES"
	self.primary_key = "ID"
	has_many :cars
end
