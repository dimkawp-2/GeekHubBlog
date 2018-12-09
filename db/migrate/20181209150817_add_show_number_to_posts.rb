class AddShowNumberToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :show, :string
  end
end
