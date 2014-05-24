class TypeOfPreparation < ActiveRecord::Base
	self.table_name = "TYPE_OF_PREPARATION"
	self.primary_key = "ID"
	has_many :preparations
end
