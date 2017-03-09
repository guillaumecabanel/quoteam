class ChangeNicknameNoNullToUser < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :nickname, :string, default: "", null: false
  end
end
