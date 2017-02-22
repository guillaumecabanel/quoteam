class AddOwnerToQuotes < ActiveRecord::Migration[5.0]
  def change
    add_reference :quotes, :user, foreign_key: true
  end
end
