class Technology < ActiveRecord::Base
  has_many :programmer_technologies
  has_many :programmers, through: :programmer_technologies
  validates :technology, presence: true
end
