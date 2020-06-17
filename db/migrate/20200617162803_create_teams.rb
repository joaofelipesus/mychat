class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :slug
      t.references :owner, null: false, foreign_key: { to_table: 'users' }
      t.timestamps
    end
  end
end
