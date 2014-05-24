class Status < ActiveRecord::Base
	self.table_name = "STATUSES"
	self.primary_key = "ID"
	has_many :orders
end
