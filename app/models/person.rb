class Person < ActiveRecord::Base

  def full_name
    "#{self.title} #{self.first_name} #{self.last_name}"
  end

end
