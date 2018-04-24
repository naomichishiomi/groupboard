class AddRoleToGroups < ActiveRecord::Migration[5.0]
  def change
    add_reference :groups, :role, foreign_key: true
  end
end
