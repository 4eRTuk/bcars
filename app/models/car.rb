class Car < ActiveRecord::Base
	# specify schema and table name
	self.table_name = "CARS"
	# specify primary key name
	# self.primary_key = "ID"
	#self.primary_key = "ID"
	# specify sequence name
	self.sequence_name = "CARS_ID_SEQ"
	# set which DATE columns should be converted to Ruby Date
	set_date_columns :assembling_date
  
	# set which DATE columns should be converted to Ruby Time
	#set_datetime_columns :last_login_time
	# set which VARCHAR2 columns should be converted to true and false
	#set_boolean_columns :manager, :active
	# set which columns should be ignored in ActiveRecord
	#ignore_table_columns :attribute1, :attribute2
	
	belongs_to :country
	belongs_to :model
	belongs_to :specification
	belongs_to :engine
	belongs_to :order
	
	validates :model_id, presence: true, length: { maximum: 10 }
	validates :specification_id, presence: true, length: { maximum: 10 }
	validates :engine_id, presence: true, length: { maximum: 10 }
	validates :price, presence: true
	
	validates :color, length: { maximum: 7 }
	validates :pts, length: { maximum: 30 }
end
