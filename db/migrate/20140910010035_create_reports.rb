class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :user_agent
      t.string :classification
      t.timestamps
    end
  end
end
