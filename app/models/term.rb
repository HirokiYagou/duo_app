class Term < ApplicationRecord
  has_many :exercises
  
  with_options presence: true do
    with_options numericality: true do
      validates :sentence_id
      validates :word_id
      validates :lesson
    end
    validates :english
    validates :japanese
  end
end
