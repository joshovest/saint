class AddIndexToCloudMatches < ActiveRecord::Migration
  def change
    add_index :cloud_matches, :cloud_id
  end
end
