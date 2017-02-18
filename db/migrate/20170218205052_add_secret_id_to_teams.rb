class AddSecretIdToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :secret_id, :string
  end
end
