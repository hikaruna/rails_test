class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.string :name
      t.integer :no
      t.references :evolution_from, index: true

      t.timestamps null: false
    end
  end
end
