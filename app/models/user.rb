class User < ActiveRecord::Base
	belongs_to :role
	has_many :orders, :dependent => :delete_all
	devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable
	before_create :set_role, :create_api_token
	validates :name, presence: true, length: { maximum: 30 }

	def admin?
		self.role.name == "lunch admin"
	end

	private

	def set_role
		self.role = Role.find_by(name: User.count == 0 ? "lunch admin" : "customer")
	end

	def create_api_token
		self.api_token = SecureRandom.urlsafe_base64
	end
end
