require 'rails_helper'

RSpec.describe Term, type: :model do
  before do
    @term = FactoryBot.build(:term)
  end
  describe "単語新規登録" do
    context '単語登録ができる時' do
      it "入力欄を全て適切に埋めれば登録できる" do
        expect(@term).to be_valid
      end
    end
    context '単語登録ができない時' do
      it 'sentence_idが空では登録できない' do
        @term.sentence_id = nil
        @term.valid?
        expect(@term.errors.full_messages).to include("Sentence can't be blank")
      end
      it 'sentence_idが数字以外では登録できない' do
        @term.sentence_id = 'abc'
        @term.valid?
        expect(@term.errors.full_messages).to include("Sentence is not a number")
      end
      it 'sentence_idが半角数字以外では登録できない' do
        @term.sentence_id = '１'
        @term.valid?
        expect(@term.errors.full_messages).to include("Sentence is not a number")
      end
      it 'word_idが空では登録できない' do
        @term.word_id = nil
        @term.valid?
        expect(@term.errors.full_messages).to include("Word can't be blank")
      end
      it 'word_idが数字以外では登録できない' do
        @term.word_id = 'abc'
        @term.valid?
        expect(@term.errors.full_messages).to include("Word is not a number")
      end
      it 'word_idが半角数字以外では登録できない' do
        @term.word_id = '１'
        @term.valid?
        expect(@term.errors.full_messages).to include("Word is not a number")
      end
      it 'lessonが空では登録できない' do
        @term.lesson = nil
        @term.valid?
        expect(@term.errors.full_messages).to include("Lesson can't be blank")
      end
      it 'lessonが数字以外では登録できない' do
        @term.lesson = 'abc'
        @term.valid?
        expect(@term.errors.full_messages).to include("Lesson is not a number")
      end
      it 'lessonが半角数字以外では登録できない' do
        @term.lesson = '１'
        @term.valid?
        expect(@term.errors.full_messages).to include("Lesson is not a number")
      end
      it 'englishが空では登録できない' do
        @term.english = nil
        @term.valid?
        expect(@term.errors.full_messages).to include("English can't be blank")
      end
      it 'japaneseが空では登録できない' do
        @term.japanese = nil
        @term.valid?
        expect(@term.errors.full_messages).to include("Japanese can't be blank")
      end
    end
  end
end
