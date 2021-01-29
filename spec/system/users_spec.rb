require 'rails_helper'

RSpec.describe "新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @profile = FactoryBot.build(:profile)
  end
  it '新規登録に成功し、トップページに遷移する' do
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    # サインアップボタンをクリックする
    click_on ('Sign up')
    # サインアップページに遷移していることを確認する
    expect(current_path).to eq new_user_registration_path
    # ユーザー情報を入力する
    fill_in 'Username', with: @user.username
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    fill_in 'Password confirmation', with: @user.password
    fill_in 'Lastname', with: @user.last_name
    fill_in 'Firstname', with: @user.first_name
    # NEXTボタンをクリックする
    click_on ('Next')
    # プロフィール登録ページに遷移していることを確認する
    expect(current_path).to eq user_registration_path
    # プロフィール情報を入力する
    fill_in 'Nickname', with: @profile.nickname
    # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
    before_count = User.count
    find('input[name="commit"]').click
    User.count - before_count == 1
    # トップページに遷移していることを確認する
    binding.pry
    expect(current_path).to eq root_path
  end
end

RSpec.describe "ログイン", type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
  end
  
  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    @profile = FactoryBot.build(:profile)
    @profile.user_id = @user.id
    @profile.save
    # サインインページへ移動する
    visit new_user_session_path
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    # ログインボタンをクリックする
    click_on ('Log in')
    # トップページに遷移していることを確認する
    expect(current_path).to eq root_path
  end
  
  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    @profile = FactoryBot.build(:profile)
    @profile.user_id = @user.id
    @profile.save
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    # 誤ったユーザー情報を入力する
    fill_in 'Email', with: "a@a.com"
    fill_in 'Password', with: "11111111"
    # ログインボタンをクリックする
    click_on ('Log in')
    # サインインページに戻ってきていることを確認する
    expect(current_path).to eq new_user_session_path
    # binding.pry
  end
end
