class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :slug
      t.references :team, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
