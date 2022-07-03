class Book < ApplicationRecord
  
  
  validates :title, presence: true
  validates :body,  presence: true, length: {maximum: 200}
  
  belongs_to :user        # :〇〇に属する！！
  has_many   :favorites, dependent: :destroy
  has_many   :book_comments, dependent: :destroy
  
  has_one_attached :image # 一つの添付物を持つ！！
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  def favorited_by?(user) # userに関する情報を受け取れる引数
    favorites.exists?(user_id: user.id)
    # favoritesテーブル内に、存在(exists)するかどうか
    # 受け取った引数(user)のuser.id(userテーブル、のid)を、user_id(カラム) に代入
  end
  
end