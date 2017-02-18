class CreateEnrollments < ActiveRecord::Migration[5.0]
  def change
    create_table :enrollments do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
    end
  end
end
