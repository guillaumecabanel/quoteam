class RenameSecretIdToInviteCode < ActiveRecord::Migration[5.0]
  def change
    rename_column :teams, :secret_id, :invite_code
  end
end
