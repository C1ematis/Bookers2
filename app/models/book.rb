class Book < ApplicationRecord

  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

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

end
