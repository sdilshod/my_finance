# == Schema Information
#
# Table name: subcategories
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer          not null
#

class Subcategory < ActiveRecord::Base

  belongs_to :category

  validates :name,
            format: {
                      with: /\A[a-zA-Zа-яА-я0-9\b\(\)]+\Z/,
                      message: 'Поле должно содержать буквы русского, латинского алфавита, цифры и знак "(" и ")"'
                    },
            presence: true

  scope :ordered_by_category, -> (category_id) { where('category_id = ?', category_id).order(:name) }

end
