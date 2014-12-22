class AddCategoryTosubcategory < ActiveRecord::Migration
  def change
    add_column :subcategories, :category_id, :integer, null: false
  end
end
