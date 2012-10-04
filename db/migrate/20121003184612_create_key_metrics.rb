class CreateKeyMetrics < ActiveRecord::Migration
  def change
    create_table :key_metrics do |t|
      t.date :date
      t.integer :visits
      t.integer :form_completes

      t.timestamps
    end
  end
end
