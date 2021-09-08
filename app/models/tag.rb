class Tag < ApplicationRecord

  has_many :tag_relations, dependent: :destroy
  has_many :books, through: :tag_relations
  
  scope :search, -> ( word ){
    where("tag_name like :q ", q: "#{word}") if word.present?
  }
end
