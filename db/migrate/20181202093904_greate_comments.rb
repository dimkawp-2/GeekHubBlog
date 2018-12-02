class GreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :user_name
      t.text :body
      t.belongs_to :post

      t.timestamps
    end
  end
end
