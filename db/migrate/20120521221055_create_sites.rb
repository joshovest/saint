class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :suite_list

      t.timestamps
    end
  end
end
