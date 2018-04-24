class AddGroupnumberToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :groupnumber, :string
  end
end
