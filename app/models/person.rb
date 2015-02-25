class Person < ActiveRecord::Base

  validates_presence_of :last_name
  validate :first_name_or_title


  def first_name_or_title
    if (title.nil? || title.empty?) && (first_name.nil? || first_name.empty?)
      errors.add(:title, "or First Name must be entered")
    end
  end


  def full_name
    "#{self.title} #{self.first_name} #{self.last_name}"
  end

end
