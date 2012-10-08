class CreateDashboardVideoNames < ActiveRecord::Migration
  def change
    create_table :dashboard_video_names do |t|
      t.string :name
      t.integer :video_starts
      t.integer :video_completes
      t.date :start_date

      t.timestamps
    end
  end
end
