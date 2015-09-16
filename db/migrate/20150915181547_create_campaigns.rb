class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :end_date
      t.string :description
      t.integer :goal

      t.timestamps null: false
    end
  end
end
