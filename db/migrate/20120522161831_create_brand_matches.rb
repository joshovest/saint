class CreateBrandMatches < ActiveRecord::Migration
  def change
    create_table :brand_matches do |t|
      t.string :match_list
      t.string :exclude_list

      t.timestamps
    end
  end
end
