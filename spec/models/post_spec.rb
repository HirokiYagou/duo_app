require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end
  describe "新規投稿機能"
    context '新規投稿ができるとき' do
      it 'フォームが全て埋まっていれば投稿できる' do
        expect(@post).to be_valid
      end
    end
    context '新規投稿ができないとき' do
      it '本文が空では投稿できない' do
        @post.content = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Content can't be blank")
      end
      it '本文が140字を超えると投稿できない' do
        text = ''
        141.times do
          text << 'a'
        end
        @post.content = text
        @post.valid?
        expect(@post.errors.full_messages).to include("Content is too long (maximum is 140 characters)")
      end
    end
end
