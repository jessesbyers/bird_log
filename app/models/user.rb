class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true


  has_many :sightings
  has_many :birds, through: :sightings

end
