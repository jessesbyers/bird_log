class CreateSightings < ActiveRecord::Migration
  def change
    create_table :sightings do |t|
      t.string :audubon_url
      t.string :date
      t.string :location
      t.string :notes
      t.integer :user_id
      t.integer :bird_id
    end
  end
end
