
class NotesFilter
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
    @notes = Note.all
    
    @notes = @notes.notes_user_logged(user) unless @user.blank?
    @notes = @notes.sort_name(@sort) if @sort.present? && sort_valid?
    @notes = @notes.without_book unless @global.blank?

    @notes
  end

  private

  def sort_valid?
    SORT_VALID_VALUES.include?(@sort)
  end
end
