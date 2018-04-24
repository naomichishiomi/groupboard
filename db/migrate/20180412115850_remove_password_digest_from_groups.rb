class RemovePasswordDigestFromGroups < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :password_digest, :string
  end
end
