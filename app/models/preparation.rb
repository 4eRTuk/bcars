class Preparation < ActiveRecord::Base
	self.table_name = "PREPARATION"
	self.sequence_name = "PREPARATION_ID_SEQ"
	#self.primary_key = "ID"
	has_and_belongs_to_many :orders, :join_table => "PREPARATION_ORDERS"
	belongs_to :type_of_preparation, :foreign_key => "type_id"
	validates :name, presence: true, length: { maximum: 40 }
	validates :type_id, presence: true
	validates :price, presence: true
	validates :info, presence: true, length: { maximum: 4000 }
	validate :validate_id
	
	private

	def validate_id
		errors.add(:type_id, "неверное!") unless TypeOfPreparation.exists?(self.type_id)
	end
end
