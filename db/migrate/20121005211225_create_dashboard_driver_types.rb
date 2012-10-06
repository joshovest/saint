class CreateDashboardDriverTypes < ActiveRecord::Migration
  def change
    create_table :dashboard_driver_types do |t|
      t.string :type
      t.integer :visits_30
      t.integer :form_completes_30
      #t.integer :visits_60
      #t.integer :form_completes_60

      t.timestamps
    end
  end
end
