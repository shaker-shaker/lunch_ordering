class User < ActiveRecord::Base
	belongs_to :role
	devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable
	before_save :set_role
	validates :name, presence: true, length: { maximum: 30 }

	def admin?
		self.role.name == "lunch admin"
	end

	private

	def set_role
		self.role = User.all.count == 0 ? Role.find_by_name('lunch admin') : Role.find_by_name('customer')
	end
end
