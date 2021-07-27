class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :talk, foreign_key: true
      t.references :user, foreign_key: true
      t.string :content
      
      t.timestamps
    end
    
    add_index :messages, [:updated_at, :talk_id]
  end
end
