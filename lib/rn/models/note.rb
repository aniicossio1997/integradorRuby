module RN
  module Models
    class Note 
      attr_accessor :book
      attr_accessor :content
      attr_reader :title
      def initialize(title,book= Models::Book.new("global"),content='')
        @book = book 
        @content = content
        @title = Helpers::Sanitizer.string(title)
      end
      def to_s
        "nota: #{title} y pertenezco al #{book}"
      end
    end
  end
end
