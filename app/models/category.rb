# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer          not null
#

class Category < ActiveRecord::Base

  has_many :subcategories, dependent: :destroy
  belongs_to :user

  validates :name,
            format: {
                      with: /\A[a-zA-Zа-яА-я0-9\b\(\)]+\Z/,
                      message: 'Поле должно содержать буквы русского, латинского алфавита, цифры и знак "(" и ")"'
                    },
            presence: true

  scope :ordered_by_user, -> (user) { user.categories.order(:name) }
end
