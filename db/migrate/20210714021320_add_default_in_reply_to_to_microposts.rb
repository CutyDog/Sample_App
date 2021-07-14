class AddDefaultInReplyToToMicroposts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :microposts, :in_reply_to, from: nil, to: 0
  end
end
