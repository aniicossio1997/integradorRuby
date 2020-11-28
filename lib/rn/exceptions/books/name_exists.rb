module RN
  module Exceptions
    module Books
      class NameExists< StandardError

        attr_reader :book
        attr_reader :message
        def initialize(book,message="Ya existe el libro #{book.upcase}")
          # Call the parent's constructor to set the message
          @message = message
          # Store the book in an instance variable
          @book = book
          super(message)
        end
        
        def to_s
          "[Exeptions:] #{message}"
        end

      end
    end
  end
end