class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :role
      t.belongs_to :person
      t.belongs_to :location
    end
  end
end
