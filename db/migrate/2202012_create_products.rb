class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |p|
      p.string :name
      p.integer :price
      p.string :sku
    end
  end
end