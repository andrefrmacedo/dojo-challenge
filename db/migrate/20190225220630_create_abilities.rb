class CreateAbilities < ActiveRecord::Migration[5.2]
  def change
    create_table :abilities do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.boolean :is_ultimate, null: false
      t.references :hero, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
