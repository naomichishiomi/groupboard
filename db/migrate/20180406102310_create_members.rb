class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.integer :number
      t.string :member_name
      t.string :password_digest
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
