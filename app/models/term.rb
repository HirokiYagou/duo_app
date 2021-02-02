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

  def self.search(keyword)
    if keyword != ""
      Term.where('english LIKE(?)', "%#{keyword}%").order('sentence_id')
    end
  end
end
