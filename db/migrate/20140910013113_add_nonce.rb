class AddNonce < ActiveRecord::Migration
  def change
    add_column :reports, :weak_id, :string
  end
end
