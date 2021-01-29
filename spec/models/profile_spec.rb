require 'rails_helper'

RSpec.describe Profile, type: :model do
  before do
    @profile = FactoryBot.build(:profile)
  end
  describe '新規登録' do
    context 'プロフィールの登録ができる時' do
      it "入力欄を全て適切に埋めれば登録できる" do
        expect(@profile).to be_valid
      end
      it "ststusが空欄でも登録できる" do
        @profile.status = nil
        expect(@profile).to be_valid
      end
      it "icon画像がなくても登録できる" do
        @profile.icon = nil
        expect(@profile).to be_valid
      end
      it "header画像がなくても登録できる" do
        @profile.header = nil
        expect(@profile).to be_valid
      end
    end
    context 'プロフィールの登録ができない時' do
      it 'nicknameが空では登録できない' do
        @profile.nickname = nil
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'nicknameが50文字以上では登録できない' do
        text = ''
        51.times do
          text << 'a'
        end
        @profile.nickname = text
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Nickname is too long (maximum is 50 characters)")
      end
      it 'statusが160文字以上では登録できない' do
        text = ''
        161.times do
          text << 'a'
        end
        @profile.status = text
        @profile.valid?
        expect(@profile.errors.full_messages).to include("Status is too long (maximum is 160 characters)")
      end
    end
  end
end
