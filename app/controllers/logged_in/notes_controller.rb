module LoggedIn
    class NotesController < LoggedInController
      before_action :set_note, only: [
        :show,
        :edit,
        :update,
        :destroy,
      ]
      def index
        @notes = user_signed_in? ? current_user.notes : User.new.notes
      end

      def new
        @note = Note.new(user:current_user)
        render :modal
      end

      def show
        render :show
      end

      def edit
        render :modal
      end

      def update
        if @note.update!(note_params)
          flash.now[:notice] = 'Modificado'
          @notes = user_signed_in? ? current_user.notes : User.new.notes
          render :index
        else
          flash.now[:alert] = 'Error'
          render :modal
        end
      end

      def create
        @note = Note.new(note_params)
        @note.user=current_user
        if @note.save
          @notes
          flash.now[:notice] = 'Creado'
          @notes = user_signed_in? ? current_user.notes : User.new.notes

          render :index
        else
          flash.now[:alert] = 'Error'
          format.js { render partial: 'modal' }
        end
      end
  
      private
      
      def set_note
        @note = Note.find(params[:id])
      end
      def note_params
        params.require(:note).permit(:title, :user_id, :book_id ,:content )
      end
    end  
end