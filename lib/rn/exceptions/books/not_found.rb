module RN
  module Exceptions
    module Books
      class NotFound< StandardError

        attr_reader :book
        attr_reader :message
        def initialize(book,message="[Error RENAME BOOK:] verifique que el #{book} exista ")
          # Call the parent's constructor to set the message
          @message = message
          # Store the book in an instance variable
          @book = book
          super(message)
        end
        
        def to_s
          puts "Exeptions: \n#{message}"
        end

      end

    end
  end
end