class CreateHeroes < ActiveRecord::Migration[5.2]
  def change
    create_table :heroes do |t|
      t.string :name, null: false
      t.string :real_name, null: false
      t.integer :health, null: false
      t.integer :armour, null: false
      t.integer :shield, null: false

      t.timestamps
    end
  end
end
