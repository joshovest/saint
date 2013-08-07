class CreateDashboardTrendedMetrics < ActiveRecord::Migration
  def change
    drop_table :key_metrics
    
    create_table :dashboard_trended_metrics do |t|
      t.date :date
      t.integer :visits
      t.integer :form_completes

      t.timestamps
    end
  end
end
