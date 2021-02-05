module LoggedIn
  class BooksController < LoggedInController
    include Download
    before_action :set_book, only: [
      :show,
      :edit,
      :update,
      :destroy,
      :download,
    ]

    def index
      @presenter = BooksLoggedInPresenter.new(params,current_user.id)
    end
    def new
      @book = Book.new(user:current_user)
    end
    def create
      @book = Book.new(book_params)
      @book.user=current_user
      
      if @book.save
        #byebug
        flash[:notice] = I18n.t(:sucess, action: :crear,models: :cuaderno)
        redirect_to logged_in_books_path
      else
        #byebug
        flash[:alert] = @book.errors.full_messages.first
        render  :new
      end
    end
    def show; end

    def edit; end

    def update
      if @book.update(book_params)
        #byebug
        flash[:notice] = I18n.t(:sucess, action: :editar, models: :cuaderno)
        #@books = user_signed_in? ? current_user.books : User.new.books
        redirect_to logged_in_books_path
      else
        flash[:alert] = @book.errors.full_messages.first
        render :edit
      end
    end

    def destroy
      @book.destroy
      if @book.errors.present?
        flash[:alert] = @book.errors.full_messages.first
      else
        flash[:notice] = t(:sucess, action: :eliminado, models: :cuaderno)
      end
      redirect_to logged_in_books_path
    end

    def download
      name_book=@book.name
      notes=@book.notes
      if !notes.empty?
        to_html(name_book,notes)
      else
        flash[:alert] = I18n.t(:error_download)
        redirect_to logged_in_books_path and return
      end

    end

    private

    def set_book
      @book = Book.find(params[:id])
    end
    def book_params
      params.require(:book).permit(:name, note_ids: [])
    end
  end  
end

