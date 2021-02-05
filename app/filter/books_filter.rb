
class BooksFilter
    include ActiveModel::Model
    SORT_VALID_VALUES ||= %w[
      asc
      desc
      ASC
      DESC
    ].freeze
    attr_accessor :user, :sort, :global
  
    def initialize(params,user)
      @user = user
     # @category_id = params[:category_id]
      @sort = params[:sort]
      @global = params[:global]
    end
  
    def call
      @books = Book.all  
      @books = @books.books_user_logged(user) unless @user.blank?
      @books = @books.sort_name(@sort) if @sort.present? && sort_valid?
      @books = @books.without_book unless @global.blank?
  
      @books
    end
  
    private
  
    def sort_valid?
      SORT_VALID_VALUES.include?(@sort)
    end
  end
  