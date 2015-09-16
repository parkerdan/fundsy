class User < ActiveRecord::Base
  has_secure_password
  # attr_accessor :password

  has_many :campaigns

  validates :email, presence: true,
            format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, presence: true

  def full_name
    "#{first_name} #{last_name}".strip
  end

end
