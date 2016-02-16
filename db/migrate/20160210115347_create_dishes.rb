class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.datetime :date
      t.decimal :price
      t.string :name
      t.belongs_to :category, index: true
      t.timestamps null: false
    end
  end
end
