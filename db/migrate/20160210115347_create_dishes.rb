class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.decimal :price
      t.string :name
      t.string :image
      t.belongs_to :category, index: true
      t.timestamps null: false
    end
  end
end
