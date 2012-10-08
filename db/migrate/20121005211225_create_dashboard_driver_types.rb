class CreateDashboardDriverTypes < ActiveRecord::Migration
  def change
    create_table :dashboard_driver_types do |t|
      t.string :driver_type
      t.integer :visits
      t.integer :form_completes
      t.date :start_date

      t.timestamps
    end
  end
end
