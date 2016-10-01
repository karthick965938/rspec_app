class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :tittle
      t.text :instructions

      t.timestamps null: false
    end
  end
end
