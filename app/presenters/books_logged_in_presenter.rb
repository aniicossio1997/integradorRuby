class BooksLoggedInPresenter
    def initialize(params,user)
      @params = params
      @user = user
    end
  
    def books
      @books ||= filter.call
                       .paginate(
                          page: @params[:page],
                          per_page: 4
                        )
    end
  
    def filter
      @filter ||= BooksFilter.new(filter_params,@user)
    end
  
    private
  
    def filter_params
      if @params[:books_filter]
        @params.require(:books_filter).permit(:user, :sort,:global)
      else
        {}
      end
    end
  end