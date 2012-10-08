class CreateDashboardClouds < ActiveRecord::Migration
  def change
    create_table :dashboard_clouds do |t|
      t.string :name
      t.date :start_date
      t.integer :page_views
      t.integer :form_completes

      t.timestamps
    end
  end
end