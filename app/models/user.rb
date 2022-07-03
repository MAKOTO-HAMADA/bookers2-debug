class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,         dependent: :destroy
  has_many :favorites,     dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # 中間テーブルを定義することで、フォローを＜した・された＞の関係を作る
  has_many :user_followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :user_followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :follower_to_followeds, through: :user_followers, source: :followed
  has_many :followed_to_followers, through: :user_followeds, source: :follower
  
  
  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 30 }
  
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  def relationship_by?(user)
    follower_to_followeds.include?(user)
  end
  
end