class CreateCloudMatches < ActiveRecord::Migration
  def change
    create_table :cloud_matches do |t|
      t.string :match_list
      t.boolean :and_match
      t.integer :cloud_id

      t.timestamps
    end
  end
end
