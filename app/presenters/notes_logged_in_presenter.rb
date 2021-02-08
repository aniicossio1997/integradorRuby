# frozen_string_literal: true

class NotesLoggedInPresenter
    def initialize(params,user)
      @params = params
      @user = user
    end
  
    def notes
      @notes ||= filter.call
                       .paginate(
                          page: @params[:page],
                          per_page: 6
                        )
    end
  
    def filter
      @filter ||= NotesFilter.new(filter_params,@user)
    end
  
    private
  
    def filter_params
      if @params[:notes_filter]
        @params.require(:notes_filter).permit(:user, :sort,:global,:book_id)
      else
        {}
      end
    end
  end