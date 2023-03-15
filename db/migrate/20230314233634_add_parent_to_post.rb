class AddParentToPost < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :posts, null: true, foreign_key: true
  end
end
