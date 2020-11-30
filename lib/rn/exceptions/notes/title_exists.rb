module RN
  module Exceptions
    module Notes
      class TitleExists< StandardError
        attr_reader :note
        attr_reader :message
        def initialize(note,message="[Error:] Ya existe la #{note}")
          # Call the parent's constructor to set the message
          @message = message
          # Store the note in an instance variable
          @note = note
          super(message)
        end
        
        def to_s
          "#{message}"
        end

      end
    end
  end
end