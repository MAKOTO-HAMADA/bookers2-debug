class Book < ApplicationRecord
  
  
  validates :title, presence: true
  validates :body,  presence: true, length: {maximum: 200}
  
  belongs_to :user        # :〇〇に属する！！
  has_one_attached :image # 一つの添付物を持つ！！
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
end