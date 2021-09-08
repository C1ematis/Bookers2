class Book < ApplicationRecord

  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_relations, dependent: :destroy
  has_many :tags, through: :tag_relations

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def tag_save(tag_list)
    current_tag_list = self.tags.pluck(:tag_name) unless self.tags.nil?
    old = current_tag_list - tag_list
    new = tag_list - current_tag_list

    old.each do |name|
      self.tags.delete Tag.find_by(tag_name: name)
    end

    new.each do |name|
      book_tag = Tag.find_or_create_by(tag_name: name)
      self.tags << book_tag
    end
  end
  
  scope :search, -> ( word ){
    where("title like :q ", q: "%#{word}%") if word.present?
  }

  def self.looks(ways, words)
    if ways == "0" #完全
      @book = Book.where("title LIKE ?", "#{words}")
    elsif ways == "1" #前方
      @book = Book.where("title LIKE ?", "#{words}%")
    elsif ways == "2" #後方
      @book = Book.where("title LIKE ?", "%#{words}")
    else #部分
      @book = Book.where("title LIKE ?", "%#{words}%")
    end
  end

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  # validates :star, presence: true

end
