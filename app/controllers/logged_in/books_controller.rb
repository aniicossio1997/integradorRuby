module LoggedIn
  class BooksController < LoggedInController
    before_action :set_book, only: [
      :show,
      :edit,
      :update,
      :destroy,
    ]
    def index
      @books = user_signed_in? ? current_user.books : User.new.books
    end
    def new
      @book = Book.new(user:current_user)
    end
    def create
      @book = Book.new(book_params)
      @book.user=current_user
      #byebug
      if @book.save
        flash.now[:notice] = 'Creado'
        redirect_to logged_in_books_path
      else
        flash[:alert] = @book.errors.full_messages.first
        render  :new
      end
    end
    def show; end

    def edit; end

    def update
      if @book.update(book_params)
        flash.now[:notice] = 'Modificado'
        #@books = user_signed_in? ? current_user.books : User.new.books
        redirect_to logged_in_books_path
      else
        flash.now[:alert] = @book.errors.full_messages.first
        render :edit
      end
    end

    def destroy; end

    private

    def set_book
      @book = Book.find(params[:id])
    end
    def book_params
      params.require(:book).permit(:name, note_ids: [])
    end
  end  
end

