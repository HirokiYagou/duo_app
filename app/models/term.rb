class Term < ApplicationRecord
  with_options presence: true do
    validates :sentence_id, format: { with: /\A[0-9]+\z/.freeze, message: 'は半角数字を入力してください' }
    validates :word_id, format: { with: /\A[0-9]+\z/.freeze, message: 'は半角数字を入力してください' }
    validates :lesson
    validates :english
    validates :japanese
  end
end
