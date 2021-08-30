class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower_user, through: :follower, source: :followed
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followed_user, through: :followed, source: :follower

  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    follower_user.include?(user)
  end
  
  def self.looks(ways, words)
    if ways == "0" #完全
      @user = User.where("name LIKE ?", "#{words}")
    elsif ways == "1" #前方
      @user = User.where("name LIKE ?", "#{words}%")
    elsif ways == "2" #後方
      @user = User.where("name LIKE ?", "%#{words}")
    else #部分
      @user = User.where("name LIKE ?", "%#{words}%")
    end
  end
    

  attachment :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
end
