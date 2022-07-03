class FavoritesController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    # params：送られてきた "値" を受け取るもの　※ ここ大事!!!!!
    
    # ４行目の params[:book_id] だけで、:book_idカラムに
    # show ページの、URL末尾の"値"や、
    # indexページの♡をクリックした時に送信された"値"を、
    # book.idとして取得している
    # だから、book_id = book.id のように代入するコードを書かなくて良い！
    
    favorite = current_user.favorites.new(book_id: book.id)
    # current_userの、favoritesテーブルに空箱を作る(new)
    # 空箱のbook_idカラムには、bookテーブルの上で定義したbookのidを入れる
    favorite.save
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end

end
