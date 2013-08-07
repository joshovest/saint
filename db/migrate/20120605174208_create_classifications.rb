class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.string :key
      t.string :name
      t.string :type
      t.string :keyword
      t.string :branded
      t.string :engine
      t.string :country
      t.string :tld
      t.string :keyword_cloud
      t.string :display_country
      t.string :display_site
      t.string :display_product
      t.string :display_date
      t.string :driver_id
      
      t.timestamps
    end
  end
end
