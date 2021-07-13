class RemoveDefaultFromMicroposts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :microposts, :in_reply_to, from: 0, to: nil
  end
end
