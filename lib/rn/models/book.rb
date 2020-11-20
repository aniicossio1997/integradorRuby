module RN
  module Models
    class Book
      #include RN::Helpers::Zanitizer
      attr_reader :name

      def initialize (name)
       # puts Helpers::Zanitizer.string("hgkg ## gato")
        @name = Helpers::Sanitizer.string(name)
      end
      def to_s 
        "Libro: #{@name}" 
      end

    end
  end
end