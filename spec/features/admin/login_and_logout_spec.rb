require 'rails_helper'

feature 'adminログインログアウト' do
  include FeaturesSpecHelper
  let(:administrator) { create(:administrator) }

  scenario 'ログイン成功' do
    visit admin_root_path

    within('form') do
      fill_in 'login_name', with: administrator.login_name
      fill_in 'password', with: 'password'
      click_button 'ログイン'
    end
    expect(page).to have_css('.alert', text: 'ログインしました')

    click_link 'ログアウト'
    expect(page).to have_css('.alert', text: 'ログアウトしました')
  end

  scenario 'ログイン失敗' do
    visit admin_root_path

    within('form') do
      fill_in 'login_name', with: administrator.login_name
      fill_in 'password', with: 'invalid_password'
      click_button 'ログイン'
    end
    expect(page).to have_css('.alert', text: 'ログインに失敗しました')
  end
end
