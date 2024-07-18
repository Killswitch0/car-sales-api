class AddLikesCountToAdvertisements < ActiveRecord::Migration[7.1]
  def change
    add_column :advertisements, :likes_count, :integer, default: 0
  end
end
