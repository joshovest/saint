class AddPositionToMatches < ActiveRecord::Migration
  def change
    add_column :brand_matches, :position, :integer
    add_column :cloud_matches, :position, :integer
  end
end
