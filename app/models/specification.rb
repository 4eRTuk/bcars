class Specification < ActiveRecord::Base
	#self.table_name = "SPECIFICATIONS"
	#self.sequence_name = "SPECIFICATIONS_ID_SEQ"
	#self.primary_key = "ID"
	has_and_belongs_to_many :engines, :join_table => "specs_engines"
	belongs_to :model
	validates :name,  presence: true, length: { maximum: 40 }
	validates :model_id,  presence: true
	validates :price,  presence: true
	validates :info,  length: { maximum: 4000 }
	validate :validate_id
	
	private

	def validate_id
		errors.add(:model_id, "неверное!") unless Model.exists?(self.model_id)
	end
end
