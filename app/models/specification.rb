class Specification < ActiveRecord::Base
	# specify schema and table name
	self.table_name = "SPECIFICATIONS"
	# specify primary key name
	#self.primary_key "ID"
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
