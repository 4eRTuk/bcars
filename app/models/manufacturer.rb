class Manufacturer < ActiveRecord::Base
	self.table_name = "MANUFACTURERS"
	has_many :models
end
