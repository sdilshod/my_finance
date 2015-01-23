require 'rails_helper'

describe 'The sign in process' do

  before :each do
    @user = create(:user)
  end

  it 'sign in user' do
    visit '/'
    expect(page.html).not_to include('<li>Операции</li>')
    expect(page).to have_content 'Войти'
    visit '/users/sign_in'
    within('form') do
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
    end
    click_button 'Войти'
    expect(current_path).to eq(root_path)
    expect(page).to have_content 'Операции Категории Субкатегории'
  end

end
