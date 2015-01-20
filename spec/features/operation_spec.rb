require 'rails_helper'

describe 'Operations' do

  before :each do
    @categories = create_list(:category, 2)
    @subcategories = create_list(:subcategory, 2, category: @categories.first)
    create_list(:operation, 2,
                sum: 5200,
                source: Operation::SOURCES[0][1],
                category: @categories.first,
                subcategory: @subcategories.first
               )
    create_list(:operation, 2,
                sum: -1200,
                source: Operation::SOURCES[1][1],
                category: @categories.first,
                subcategory: @subcategories.first
               )

    @user = create(:user)
    visit '/users/sign_in'
    within('form') do
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
    end
    click_button 'Log in'
    visit '/operations'
  end

  describe 'main page' do
    it 'should contain elements' do
      expect(page).to have_selector '.currency_info'
      expect(page).to have_content "#{number_to_currency(10400, unit: '')}"
      expect(page).to have_content "#{number_to_currency(-2400, unit: '')}"
      expect(page).to have_selector '.btn-default'
      expect(page).to have_selector 'table'
    end
  end

  describe 'add new one' do
    it 'should get error' do
      click_link 'Добавить'
      expect(current_path).to eq(new_operation_path)
      click_button "Сохранить"
      expect(page).to have_content 'sum'
      expect(page).to have_content 'не может быть пустым'
    end

    it 'should create operation' do
      click_link 'Добавить'
      expect(current_path).to eq(new_operation_path)
      expect(page.html).to include('<option value="1">Наличка</option>')
      within('form') do
        fill_in 'operation_sum', with: 15000
      end
      click_button "Сохранить"
      expect(current_path).to eq(operations_path)
    end
  end

  describe 'filter by conditions' do

    it 'should perform filter' do
      click_link 'Фильтр'
      expect(current_path).to eq(list_filter_operations_path)
      expect(page.html).to include('<option value="1">Наличка</option>')
      within('form') do
        select  Operation::SOURCES[0][0], from: 'filter_source'
      end
      click_button 'Выполнить'
      expect(page).to have_content "#{number_to_currency(10400, unit: '')}"
      expect(page).to have_content "#{number_to_currency(0, unit: '')}"
      expect(page).to have_content 'Отбор:'
    end

    it 'should not perform filter' do
      click_link 'Фильтр'
      expect(current_path).to eq(list_filter_operations_path)
      click_button 'Выполнить'
      expect(page).to have_content "#{number_to_currency(10400, unit: '')}"
      expect(page).to have_content "#{number_to_currency(-2400, unit: '')}"
      expect(page).not_to have_content 'Отбор:'
    end
  end

end
