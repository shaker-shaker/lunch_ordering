class User < ActiveRecord::Base
  has_many :orders, dependent: :delete_all
  has_and_belongs_to_many :roles
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable
  before_create :set_role, :create_api_token
  validates :name, presence: true, length: { maximum: 30 }

  def admin?
    has_role?("lunch admin")
  end

  private

  def has_role?(*role_names)
    roles.where(name: role_names).present?
  end

  def set_role
    roles << Role.find_by(name: "customer")
    roles << Role.find_by(name: "lunch admin") if User.count.zero?
  end

  def create_api_token
    self.api_token = SecureRandom.urlsafe_base64
  end
end
