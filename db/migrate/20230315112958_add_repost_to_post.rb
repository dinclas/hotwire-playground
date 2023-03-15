class AddRepostToPost < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :repost, null: true, index: true, foreign_key: { to_table: :posts }
  end
end
