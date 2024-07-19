class AddStateToAdvertisements < ActiveRecord::Migration[7.1]
  def change
    add_column :advertisements, :state, :integer, default: 0
  end
end
