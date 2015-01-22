class AddUserToModels < ActiveRecord::Migration
  def up
    add_column :operations, :user_id, :integer
    add_column :categories, :user_id, :integer

    user = User.first
    if user
      operations = Operation.all
      operations.each do |e|
        e.user_id = user.id
        e.save
      end

      categories = Category.all
      categories.each do |e|
        e.user_id = user.id
        e.save
      end
    end

    change_column :operations, :user_id, :integer, null: false
    change_column :categories, :user_id, :integer, null: false
    User.create email: 'guest@guest.com', password: 'password'

  end

  def down
    remove_column :operations, :user_id
    remove_column :categories, :user_id

    guest_user = User.find_by_email 'guest@guest.com'
    guest_user.destroy if guest_user
  end
end
