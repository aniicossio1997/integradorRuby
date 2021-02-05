
class NotesFilter
  include ActiveModel::Model
  SORT_VALID_VALUES ||= %w[
    asc
    desc
    ASC
    DESC
  ].freeze
  attr_accessor :user, :sort, :global,:book_id

  def initialize(params,user)
    @user = user
   # @category_id = params[:category_id]
    @sort = params[:sort]
    #@global = params[:global]
    @book_id=params[:book_id]
  end

  def call
    @notes = Note.all
    #byebug
    @notes = @notes.notes_user_logged(user) unless @user.blank?
    @notes = @notes.sort_name(@sort) if @sort.present? && sort_valid?
    @notes = ((@book_id.to_i).zero? ? @notes.without_book : @notes.only_book(@book_id.to_i)) unless (@book_id.blank? || @book_id.nil?)
    
    @notes
  end

  private

  def sort_valid?
    SORT_VALID_VALUES.include?(@sort)
  end
end
