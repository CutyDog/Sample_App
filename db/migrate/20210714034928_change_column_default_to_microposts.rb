class ChangeColumnDefaultToMicroposts < ActiveRecord::Migration[5.2]
  def change
    change_column :microposts, :in_reply_to, :integer
  end
end
