class Term < ApplicationRecord
  has_many :exercises
  has_many :post_terms
  has_many :posts, through: :post_terms
  
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
      Term.where('english LIKE(?)', "%#{keyword}%").where.not(word_id: 0).order(:sentence_id).first(10)
    end
  end
end
