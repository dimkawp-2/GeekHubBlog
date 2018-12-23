class AddAncestryToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :ancestry, :string
  end
end
