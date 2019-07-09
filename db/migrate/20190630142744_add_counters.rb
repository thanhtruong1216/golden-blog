class AddCounters < ActiveRecord::Migration[6.0]
  def change
    change_table :posts, bulk: true do |t|
      t.integer :comments_count, default: 0
      t.integer :likes_count, default: 0
    end
  end
end
