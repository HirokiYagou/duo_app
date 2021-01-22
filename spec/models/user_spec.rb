require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "新規登録" do
    context 'ユーザー登録ができる時' do
      it "入力欄を全て適切に埋めれば登録できる" do
        expect(@user).to be_valid
      end
    end
    
    context 'ユーザー登録ができない時' do
      it 'ユーザー名が空では登録できない' do
        @user.username = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Username can't be blank")
      end
      it '同じユーザー名では登録できない' do
        @user.save
        user2 = FactoryBot.build(:user)
        user2.username = @user.username
        user2.valid?
        expect(user2.errors.full_messages).to include("Username has already been taken")
      end
      it 'ユーザー名の大文字小文字は区別されず、同じユーザー名として登録できない' do
        @user.save
        user2 = FactoryBot.build(:user)
        user2.username = @user.username.downcase
        user2.valid?
        expect(user2.errors.full_messages).to include("Username has already been taken")
      end
      it 'アンダーバー以外の記号は登録できない' do
        @user.username << '-'
        @user.valid?
        expect(@user.errors.full_messages).to include("Username は英字、数字、アンダーバーを入力してください")
      end
      it 'メールアドレスが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '同じメールアドレスでは登録できない' do
        @user.save
        user2 = FactoryBot.build(:user)
        user2.email = @user.email
        user2.valid?
        expect(user2.errors.full_messages).to include("Email has already been taken")
      end
      it 'パスワードが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが5文字以下では登録できない' do
        @user.password = 'aaaa1'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードが数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角で英字と数字の両方を含めて設定してください')
      end
      it 'パスワードが英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角で英字と数字の両方を含めて設定してください')
      end
      it 'パスワードが全角では登録できない' do
        @user.password = 'ａ１ａ１ａ１'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角で英字と数字の両方を含めて設定してください')
      end
      it 'パスワードとパスワード（確認用）の値が一致しないと登録できない' do
        @user.password_confirmation = 'a1a1a1'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '本名の苗字が空では登録できない' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '本名の苗字が英字以外では登録できない' do
        @user.last_name = '加藤'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name は英字で入力してください")
      end
      it '本名の名前が空では登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '本名の名前が英字以外では登録できない' do
        @user.first_name = 'りく'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name は英字で入力してください")
      end
    end
  end
end
