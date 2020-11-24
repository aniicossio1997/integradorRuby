module RN
  module Models
    class note 
      attr_accessor :book, :content
      attr_reader :title
      def initialize(title,book,content='')
        @book = book || ENV['RN_GLOBAL_BOOK_NAME']
        @content = content
        @title = title
      end
    end
  end
end
