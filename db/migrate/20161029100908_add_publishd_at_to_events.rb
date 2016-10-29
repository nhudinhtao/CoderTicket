class AddPublishdAtToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :published_at, :datetime
  end
end
