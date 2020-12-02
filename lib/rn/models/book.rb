require "find"

module RN
  module Models
    class Book
      include Helpers::Enum
      attr_reader :name
      # PATH = Helpers::Enum::PATH
      # Enum = Helpers::Enum
      def initialize (name)
        (!name.nil? && !name.strip.empty?)  || raise("el nombre del libro no puede ser un vacio")
        @name = Helpers::Sanitizer.string(name)        
      end
      def to_s 
        "Libro: #{@name}" 
      end
      def name_upcase
        name.upcase
      end
      def path
        @path="#{PATH}/#{name}"
        @path
      end

      def save
        !Dir.exists?(self.path) || raise(Exceptions::Books::NameExists.new(name))
        FileUtils.mkdir_p(self.path)
      end

      def delete
        Dir.exists?(self.path) || raise(Exceptions::Books::Generico.new('DELETE', "El #{self} no se encontro"))
        !(name ==GLOBAL) || raise(Exceptions::Books::Generico.new('', "No se puede eliminar la carpeta global, ya que es una carpeta por defecto del sistema"))
        FileUtils.rm_rf(self.path)
      end
      
      def self.books_whitout_global
        (Dir.entries(PATH).reject {|x| x =~ /global|[\W]/ }).join("\n")
      end
      def rename(new_book)
        (self.name != "global" ) || raise(Exceptions::Books::Generico.new('[ERROR GLOBAL:]', "el #{self} nose se puede renombrar"))
        #(Dir.exists?(new_book.path) && Dir.exists?(path)) || raise(Exceptions::Books::NameExists.new(new_book))        
        !Dir.exists?(new_book.path) || raise(Exceptions::Books::Generico.new('[Error:]', "el #{new_book} ya existe"))               
        File.rename(self.path, new_book.path)
      end

      def exists_note?(note_title)
        #(Dir.entries(ENV['HOME']+"/.my_rns/").select {|f| !File.directory? f} )
        File.file?("#{self.path}/#{note_title}.rn")
      end

      def notes
        self.notes_with_path_full.map{|each| (File.basename(each,".rn"))}
      end

      def self.all_notes
        notes=Array.new
        Models::Book.report_all_notes.each {|a_book| a_book.notes.empty? ? '' : (notes.push(a_book.notes))}
        notes.join("\n ")
      end
      def self.all_instancias_book
        names_of_books=Models::Book.all_books
        names_of_books.map {|book| (Models::Book.new(book))} 
      end

      def notes_with_path_full
        Dir.exists?(self.path) || raise(Exceptions::Books::NotFound.new(self))
        Dir.children("#{self.path}").reject{|each| (File.basename(each,".rn")).size==each.size}
      end

      def report_my_notes(all=nil)
        self.my_notes_not_empty.each {|note| (Models::Note.new(note,self.name)).report(all)}
      end
      def my_notes_not_empty
        (self.notes).reject{ |note| (Models::Note.new(note,self.name)).empty? }
      end
      def self.all_books
        Dir.entries(PATH).reject {|x| x =~ /[\W]/ }
      end

      def self.report_all_notes
        Models::Book.all_instancias_book.each{ |book| book.report_my_notes(true)}
        
      end

    end
  end
end