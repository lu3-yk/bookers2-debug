class BooksController < ApplicationController
  
before_action :authenticate_user!
before_action :correct_user, only: [:edit, :update]
  def show
    @book = Book.find(params[:id])
    @user=@book.user
    @books=Book.new
    @book_comment = BookComment.new
    @book_detail = Book.find(params[:id])
     unless ViewCount.find_by(user_id: current_user.id, book_id: @book_detail.id)
      current_user.view_counts.create(book_id: @book_detail.id)
     end
  end

  
  def index
    to  = Time.current.at_end_of_day #toはなんでもいいイコールの後に入れたいものを入れるため。Timeというメソッドを使う。.current.at_end_of_day（その日の終わり）するとその後に引き出せる
    from  = (to - 6.day).at_beginning_of_day#fromではto-6.dayat_beginning_of_dayで−６前の始まりから
    @books = Book.all.sort {|a,b| #book.allの中からsortで比較して比べる
      b.favorites.where(created_at: from...to).size <=> #fromの始まりからtoの終わりまで
      a.favorites.where(created_at: from...to).size
    }
    @book = Book.new
  end
  

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
