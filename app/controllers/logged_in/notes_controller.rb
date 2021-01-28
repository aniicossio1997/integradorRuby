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
      end

      def show
      end

      def edit;end

      def update
        if @note.update(note_params)
          flash.now[:notice] = 'Modificado'
          #@notes = user_signed_in? ? current_user.notes : User.new.notes
          redirect_to logged_in_notes_path
        else
          flash.now[:alert] = @note.errors.full_messages.first
          render :edit
        end
      end

      def create
        @note = Note.new(note_params)
        @note.user=current_user
        #byebug
        if @note.save
          flash.now[:notice] = 'Creado'
          redirect_to logged_in_notes_path
        else
          flash[:alert] = @note.errors.full_messages.first
          render  :new
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