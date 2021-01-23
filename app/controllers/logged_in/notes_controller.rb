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
      def show
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