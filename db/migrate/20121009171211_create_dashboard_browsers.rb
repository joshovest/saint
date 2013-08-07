class CreateDashboardBrowsers < ActiveRecord::Migration
  def change
    create_table :dashboard_browsers do |t|
      t.string :name
      t.integer :visits
      t.integer :form_completes
      t.date :start_date

      t.timestamps
    end
  end
end
