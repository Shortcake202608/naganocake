class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.references :genre, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.integer :price
      t.boolean :is_active

      t.timestamps
    end
  end
end
