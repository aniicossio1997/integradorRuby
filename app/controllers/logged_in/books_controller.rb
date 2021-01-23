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
    def show; end

    def edit; end

    def update; end

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

