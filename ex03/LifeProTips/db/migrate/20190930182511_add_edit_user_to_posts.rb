class AddEditUserToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :edit_by_user_id, :integer
  end
end
