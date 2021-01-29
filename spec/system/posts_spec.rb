require 'rails_helper'

RSpec.describe "Posts", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @profile = FactoryBot.build(:profile)
    @profile.user_id = @user.id
    @profile.save
    @post = FactoryBot.build(:post)
  end
  
  context '投稿ができるとき'do
  it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('NEW POST')
      # 投稿フォームを開く
      click_on ('NEW POST')
      # フォームに情報を入力する
      fill_in 'post-content', with: @post.content
      # 画像を添付する
      image_path = Rails.root.join('public/images/icon11.png')
      attach_file('post[image]', image_path, make_visible: true)
      # 送信するとTweetモデルのカウントが1上がることを確認する
      before_count = Post.count
      click_on ('投稿する')
      Post.count - before_count == 1
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector 'img[alt="Placeholder image"]'
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@post.content)
    end
  end
  
  context '投稿の編集、削除ができるとき' do
    it '投稿したユーザーはその投稿を編集、削除できる' do
      # ログインして投稿する
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      @post.user_id = @user.id
      @post.save
      # 投稿したユーザーには編集、削除ボタンが表示される
      expect(page).to have_selector '#menu-bar[src="/assets/bars_24.png"]'
      # Editをクリックしてフォームを表示させる
      find('#menu-bar').hover
      find('#edit').click
      # フォームの情報を編集する
      edit_content = Faker::Team.name
      fill_in 'post-content', with: edit_content
      # 送信してもPOSTモデルのカウントは変わらないことを確認する
      before_count = Post.count
      click_on ('編集する')
      Post.count == before_count
      # 編集前のcontentが存在しないことを確認する
      expect(page).to have_no_content(@post.content)
      # 編集後のcontentが存在することを確認する
      expect(page).to have_content(edit_content)
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector 'img[alt="Placeholder image"]'
      # 削除をクリックするとPOSTモデルのカウントが1減ることを確認する
      find('#menu-bar').hover
      find('#delete').click
      Post.count - before_count = -1
      # binding.pry
    end
  end
  context '投稿の編集、削除ができないとき'
    it '投稿したユーザーと異なるユーザーは編集、削除ができない' do
      # 投稿する
      @post.user_id = @user.id
      @post.save
      # 異なるユーザーで登録する
      user2 = FactoryBot.create(:user)
      profile2 = FactoryBot.build(:profile)
      profile2.user_id = user2.id
      profile2.save
      # user2でログインする
      visit new_user_session_path
      fill_in 'Email', with: user2.email
      fill_in 'Password', with: user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿したユーザーには編集、削除ボタンが表示されない
      expect(page).to have_no_selector '#menu-bar[src="/assets/bars_24.png"]'
    end
end
