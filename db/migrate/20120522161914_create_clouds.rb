class CreateClouds < ActiveRecord::Migration
  def change
    create_table :clouds do |t|
      t.string :name

      t.timestamps
    end
  end
end
