module RN
  module Models
    class Book
      #include RN::Helpers::Zanitizer
      attr_reader :name
      PATH = Helpers::Enum::PATH
      Enum = Helpers::Enum
      def initialize (name)
       # puts Helpers::Zanitizer.string("hgkg ## gato")
        @name = Helpers::Sanitizer.string(name)
      end
      def to_s 
        "Libro: #{@name}" 
      end
      def name_upcase
        name.upcase
      end
      def path
        "#{Helpers::Enum::PATH}/#{name}"
      end
      def save
      end
      def exists_note?(note_title)
        #(Dir.entries(ENV['HOME']+"/.my_rns/").select {|f| !File.directory? f} )
        File.file?("#{Enum.full_path_book(name)}/#{note_title}.rn")
      end
      def notes
        Dir.exists?(self.path) || raise(Exceptions::Books::NotFound.new(self))
        (Dir.children("#{PATH}/#{name}")).join("\n")
      end
      def self.all_notes
        names_of_books=Models::Book.all_books
        object_books=Array.new
        names_of_books.each {|book| object_books.push(Models::Book.new(book))}
        notes=Array.new
        object_books.each {|a_book| a_book.notes.empty? ? '' : (notes.push(a_book.notes))}
        #notes.delete_if {|elemento| elemento.nil? || elemento.empty? }
        notes.join("\n ")
      end

      def self.all_books
        Dir.entries(Helpers::Enum::PATH).reject {|x| x =~ /[\W]/ }
      end
    end
  end
end