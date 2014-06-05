class Person < ActiveRecord::Base
	self.table_name = "person"
	#self.sequence_name = "PERSON_ID_SEQ"
	#set_date_columns :dob
	
	has_many :orders, :foreign_key => "client_id"

	before_save { self.email = email.downcase }	
	before_create :create_remember_token
	VALID_NAME_REGEX = /\A[a-zA-Zа-яА-Я]+\z/
	validates :firstname,  presence: true, length: { maximum: 30 }, format: { with: VALID_NAME_REGEX }
	validates :lastname,  presence: true, length: { maximum: 30 }, format: { with: VALID_NAME_REGEX }
	validates :middlename,  presence: true, length: { maximum: 30 }, format: { with: VALID_NAME_REGEX }
	validates :dob,  presence: true
	validates :gender,  length: { maximum: 1 }
	VALID_EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :phone,  length: { maximum: 11 }
	
	validates :password, length: { minimum: 6 }
	has_secure_password
	
	def Person.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def Person.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end
	
	def self.search(id, email, firstname, lastname, middlename, phone)
		s = ''
				sr = s.mb_chars.downcase.to_s
		i = 0
		s = "ID = #{id}" unless id.blank?
		s += " AND " if i < s.length
		i = s.length
		s += "LOWER(EMAIL) LIKE '%#{email.downcase}%'" unless email.blank?
		s += " AND " if i < s.length
		i = s.length
		s += "LOWER(FIRSTNAME) LIKE '%#{firstname.mb_chars.downcase.to_s}%'" unless firstname.blank?
		s += " AND " if i < s.length
		i = s.length
		s += "LOWER(LASTNAME) LIKE '%#{lastname.mb_chars.downcase.to_s}%'" unless lastname.blank?
		s += " AND " if i < s.length
		i = s.length
		s += "LOWER(MIDDLENAME) LIKE '%#{middlename.mb_chars.downcase.to_s}%'" unless middlename.blank?
		s += " AND " if i < s.length
		i = s.length
		s += "PHONE LIKE '%#{phone}%'" unless phone.blank?
		s += " AND " if i < s.length
		i = s.length
		s += "ACS_LEVEL >= 0"
		
		if !s.blank?
			where s
		else
			scoped
		end
	end
	
	private

    def create_remember_token
		self.remember_token = Person.encrypt(Person.new_remember_token)
    end
end
