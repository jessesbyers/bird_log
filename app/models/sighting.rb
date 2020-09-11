class Sighting < ActiveRecord::Base
  belongs_to :user
  belongs_to :bird
  validates :audubon_url, :date, :location, :notes, presence: true

end
