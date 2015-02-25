class Assignment < ActiveRecord::Base

  belongs_to :location

  validates :location_id, uniqueness: {scope: :role,
  message: "You cannot add the same role to the same location"}

end
