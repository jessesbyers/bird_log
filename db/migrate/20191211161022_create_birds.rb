class CreateBirds < ActiveRecord::Migration
  def change
    create_table :birds do |t|
      t.string :common_name
  	  t.string :scientific_name
  	  t.string :family
  	  t.string :description
  	  t.string :conservation_status
  	  t.string :habitat
  	  t.string :feeding_behavior
  	  t.string :eggs
  	  t.string :young
  	  t.string :diet
  	  t.string :image
    end
  end
end
