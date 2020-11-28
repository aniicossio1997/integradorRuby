module RN
  module Exceptions
    module Books
      autoload :NotFound, 'rn/exceptions/books/not_found'
      autoload :NameExists, 'rn/exceptions/books/name_exists'
      
      class Generico< StandardError
        attr_reader :message
        attr_reader :type
        def initialize(type,message)
          # Call the parent's constructor to set the message
          # Store the book in an instance variable
          super(message)
          @type = type
          @message = message
        end
        
        def to_s
          "[ERROR:]  #{message}"
        end
      end
    end
  end
end
