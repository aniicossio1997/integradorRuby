module LoggedIn
    class NotesController < LoggedInController
      include Download
      include Destroy
      before_action :set_note, only: [
        :show,
        :edit,
        :update,
        :destroy,
        :download,
      ]
      before_action :set_note, except: [
        :index,
        :download_global,
        :new,
        :create,
        :download_all,
        :destroy_global,
        :destroy_all,

      ]
      def index
        @presenter = NotesLoggedInPresenter.new(params,current_user.id)

      end

      def new
        @note = Note.new(user:current_user)
      end

      def show;end
      def edit;end

      def update
        if @note.update(note_params)
          flash[:notice] = t(:sucess, action: :editado, models: :nota)
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
          flash[:notice] = t(:sucess, action: :creado, models: :nota)
          redirect_to logged_in_notes_path
        else
          flash.now[:alert] = @note.errors.full_messages.first
          render  :new
        end
      end

      def destroy
        @note.destroy
        if @note.errors.present?
          flash[:alert] = @note.errors.full_messages.first
        else
          flash[:notice] = t(:sucess, action: :eliminado, models: @note)
        end
        redirect_to logged_in_notes_path
      end

      def download
        send_data(@note.markdown, filename:"#{@note.title_for_download}.html", type: "html", disposition: "attachment")
      end

      def download_global
        name_book="global"
        notes=Note.notes_global(current_user.id)
        if !notes.empty?
          to_html(name_book,notes)
        else
          flash[:alert] = I18n.t(:error_download)
          redirect_to logged_in_books_path and return
        end
      end

      def download_all
        name_book="all"
        notes=current_user.notes
        if !notes.empty?
          to_html(name_book,notes)
        else
          flash[:alert] = I18n.t(:error_download)
          redirect_to logged_in_books_path and return
        end
      end

      def destroy_global
        notes=Note.notes_global(current_user.id)
        destroy_cascada(notes,I18n.t(:message_sucess_global_note),I18n.t(:message_error_global_note))
        redirect_to logged_in_notes_path
      end
      def destroy_all
        notes= current_user.notes
        destroy_cascada(notes,I18n.t(:message_sucess_all_note),I18n.t(:message_error_all_note))
        redirect_to logged_in_notes_path
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