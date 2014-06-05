class Model < ActiveRecord::Base
	#self.table_name = "MODELS"
	#self.sequence_name = "MODELS_ID_SEQ"
	belongs_to :manufacturer
	has_many :cars
	has_many :specifications
	has_many :options
	validates :name,  presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
	validates :manufacturer_id,  presence: true
	validate :validate_id
	
	def self.search(q, m)
		s=''
		s = "LOWER(NAME) LIKE '%#{q.downcase}%'" unless q.blank?
		s+= " AND " if !s.blank? && !m.blank?
		s+= "MANUFACTURER_ID = #{m}" unless m.blank?
	
		if !s.blank?
			where s
		else
			scoped
		end
	end
	
	private

	def validate_id
		errors.add(:manufacturer_id, "неверное!") unless Manufacturer.exists?(self.manufacturer_id)
	end
end
