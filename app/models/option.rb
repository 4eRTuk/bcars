class Option < ActiveRecord::Base
	# specify schema and table name
	self.table_name = "OPTIONS"
	#self.primary_key = "ID"
	self.sequence_name = "OPTIONS_ID_SEQ"
	has_and_belongs_to_many :orders, :join_table => "OPTIONS_ORDER"
	belongs_to :type_of_option, :foreign_key => "type_id"
	belongs_to :model
	validates :name, presence: true, length: { maximum: 40 }
	validates :type_id, presence: true
	validates :price, presence: true
	validates :info, presence: true, length: { maximum: 4000 }
	validate :validate_id
	
	private

	def validate_id
		errors.add(:type_id, "неверное!") unless TypeOfOption.exists?(self.type_id)
	end
  # specify sequence name
  #self.sequence_name "hr.hr_employee_s"
  # set which DATE columns should be converted to Ruby Date
  #set_date_columns :hired_on, :birth_date_on
  # set which DATE columns should be converted to Ruby Time
  #set_datetime_columns :last_login_time
  # set which VARCHAR2 columns should be converted to true and false
  #set_boolean_columns :manager, :active
  # set which columns should be ignored in ActiveRecord
  #ignore_table_columns :attribute1, :attribute2

	
end
