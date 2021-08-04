class CreateTalks < ActiveRecord::Migration[5.2]
  def change
    create_table :talks do |t|
      
    t.timestamps
    end
    
    add_index :talks, :updated_at
  end
end
