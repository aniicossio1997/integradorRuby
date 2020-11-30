module RN
  module Models
    class Book
      attr_reader :name
      PATH = Helpers::Enum::PATH
      Enum = Helpers::Enum
      def initialize (name)
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
        !Dir.exists?(self.path) || raise(Exceptions::Books::NameExists.new(name))
        FileUtils.mkdir_p(self.path)
      end

      def delete
        Dir.exists?(self.path) || raise(Exceptions::Books::Generico.new('DELETE', "El #{self} no se encontro"))
        !(name ==Enum::GLOBAL) || raise(Exceptions::Books::Generico.new('', "No se puede eliminar la carpeta global, ya que es una carpeta por defecto del sistema"))
        FileUtils.rm_rf(self.path)
      end
      
      def self.books_whitout_global
        (Dir.entries(Enum::PATH).reject {|x| x =~ /global|[\W]/ }).join("\n")
      end
      def rename(new_book)
        (self.name != "global" ) || raise(Exceptions::Books::Generico.new('[ERROR RENAME GLOBAL]', "el #{self} nose se puede renombrar"))
        File.rename(self.path, new_book.path) 
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
        notes.join("\n ")
      end

      def self.all_books
        Dir.entries(Helpers::Enum::PATH).reject {|x| x =~ /[\W]/ }
      end


    end
  end
end