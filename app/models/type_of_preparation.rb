class TypeOfPreparation < ActiveRecord::Base
	self.table_name = "type_of_preparation"
	#self.primary_key = "ID"
	has_many :preparations
end
