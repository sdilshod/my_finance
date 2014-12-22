class Tables < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :null => false
      t.timestamps
    end

    create_table :subcategories do |t|
      t.string :name, :null => false
      t.timestamps
    end

    create_table :operations do |t|
      t.date :date, :null => false
      t.decimal :sum, precision: 15, scale: 2, null: false
      t.string :source, null: false
      t.integer :category_id, null: false
      t.integer :subcategory_id
      t.string :comment
      t.timestamps
    end

    add_index :operations, :date

  end
end
