require 'rails_helper'

feature 'account新規登録' do
  include FeaturesSpecHelper

  before do
    visit new_account_path
  end

  scenario '作成成功' do
    within('form#new_account') do
      fill_in 'account_identify_name', with: "testman"
      fill_in 'account_email', with: 'testman@example.com'
      fill_in 'account_password', with: 'password'
      fill_in 'account_password_confirmation', with: 'password'
      click_button '登録する'
    end
    expect(page).to have_css('.alert', text: '新規登録しました')

    new_account = Account.order('id').last
    expect(new_account.identify_name).to eq('testman')
    expect(new_account.email).to eq('testman@example.com')
  end

  scenario '作成失敗' do
    within('form#new_account') do
      fill_in 'account_identify_name', with: "account"
      fill_in 'account_email', with: 'testmanexample.com'
      fill_in 'account_password', with: 'hoge'
      fill_in 'account_password_confirmation', with: 'password'
      click_button '登録する'
    end
    expect(page).to have_css('.alert', text: '新規登録に失敗しました')
    pending 'Rails5 update に集中したいので後回し'
    expect(page).to have_css("p", text: 'ログイン名( id )は既に登録されてあります。')
    expect(page).to have_css("p", text: 'メールアドレスが不正な値です。')
    expect(page).to have_css("p", text: 'パスワード再入力が間違っています。')
  end
end
