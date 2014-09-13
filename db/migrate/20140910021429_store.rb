class Store < ActiveRecord::Migration
  def change
    add_column :reports, :report, :text, :limit => nil
  end
end
