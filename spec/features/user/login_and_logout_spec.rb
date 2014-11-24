require 'rails_helper'

feature 'userログインログアウト' do
  include FeaturesSpecHelper
  let(:account) { create(:account) }

  scenario 'ログイン成功' do
    visit new_session_path

    within('form') do
      fill_in 'identify_name', with: account.identify_name
      fill_in 'password', with: 'password'
      click_button 'ログイン'
    end
    expect(page).to have_css('.alert', text: 'ログインしました')

    click_link 'ログアウト'
    expect(page).to have_css('.alert', text: 'ログアウトしました')
  end

  scenario 'ログイン失敗' do
    visit new_session_path

    within('form') do
      fill_in 'identify_name', with: account.identify_name
      fill_in 'password', with: 'invalid_password'
      click_button 'ログイン'
    end
    expect(page).to have_css('.alert', text: 'ログインに失敗しました')
  end
end
