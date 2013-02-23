class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :code
      t.integer :user_id
      t.string :email

      t.timestamps
    end
  end
end
