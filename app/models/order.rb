class Order < ActiveRecord::Base
	#self.table_name = "ORDERS"
	#self.sequence_name = "ORDERS_ID_SEQ"
	#self.primary_key = "ID"
	has_and_belongs_to_many :preparations, :join_table => "preparation_orders"
	has_and_belongs_to_many :options, :join_table => "options_orders"
	belongs_to :person, :foreign_key => "client_id"
	belongs_to :car
	belongs_to :status
	
	def self.search(status_id, s)
		q = ''
		q += "STATUS_ID = #{status_id}" if !status_id.blank?
		
		if !s.blank? && s.to_i > 0
			q += " AND " unless q.blank?
			q += "ID = #{s}"
			where q
		else
			if s.blank?
				where q
			else
				r = where q
				sr = s.mb_chars.downcase.to_s
				r.includes(:person, car: [{model: :manufacturer}]).where "LOWER(PERSON.EMAIL) LIKE '%#{s.downcase}%' OR LOWER(PERSON.FIRSTNAME) LIKE '%#{sr}%' OR LOWER(PERSON.MIDDLENAME) LIKE '%#{sr}%' OR LOWER(PERSON.LASTNAME) LIKE '%#{sr}%' OR LOWER(MODELS.NAME) LIKE '%#{s.downcase}%' OR LOWER(MANUFACTURERS.NAME) LIKE '%#{s.downcase}%'"
			end
		end
	end
end
