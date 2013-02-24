class AddCodeIndexToInvites < ActiveRecord::Migration
  def change
    add_index :invites, :code
  end
end
