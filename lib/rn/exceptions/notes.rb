module RN
  module Exceptions
    module Notes
      autoload :TitleExists, 'rn/exceptions/note/title_exists'
      class Exists< StandardError
        attr_reader :note
        attr_reader :message
        def initialize(note,message="Ya existe la #{note} en el #{note.book}")
          # Call the parent's constructor to set the message
          @message = message
          # Store the note in an instance variable
          @note = note
          super(message)
        end
        def to_s
          "[Exeptions:] #{message}"
        end

      end
      class Error< StandardError
        attr_reader :message
        attr_reader :action
        def initialize(action="",message="")
          # Call the parent's constructor to set the message
          
          # Store the note in an instance variable
          super(message)
          @message = message
          @action= action
        end
        def to_s
          "[ERROR:]  #{action}  #{message}"
        end

      end

    end
  end
end