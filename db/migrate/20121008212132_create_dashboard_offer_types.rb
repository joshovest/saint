class CreateDashboardOfferTypes < ActiveRecord::Migration
  def change
    create_table :dashboard_offer_types do |t|
      t.string :name
      t.date :start_date
      t.integer :form_views
      t.integer :form_completes

      t.timestamps
    end
  end
end
