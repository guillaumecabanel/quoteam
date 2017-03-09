class ChangeNicknameDefaultToUser < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :nickname, :string, default: ""
  end
end
