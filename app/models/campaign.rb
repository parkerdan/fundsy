class Campaign < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :goal, presence: true,
            numericality: {greater_than: 10}
  validates :description, presence: true
  validates :title, uniqueness: true          

end
