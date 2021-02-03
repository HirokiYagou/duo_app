class PostTerm < ApplicationRecord
  belongs_to :post
  belongs_to :term
end
