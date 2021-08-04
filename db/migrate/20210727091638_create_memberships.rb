class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.references :talk, foreign_key: true
      t.references :user, foreign_key: true
      
      t.timestamps
    end
    
    add_index :memberships, [:user_id, :talk_id], unique: true
  end
end
