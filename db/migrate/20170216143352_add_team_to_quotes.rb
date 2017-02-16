class AddTeamToQuotes < ActiveRecord::Migration[5.0]
  def change
    add_reference :quotes, :team, foreign_key: true
  end
end
