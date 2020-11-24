module RN
  module Helpers
    class Book
      def self.create(book)
          !Dir.exists?(Helpers::Enum.full_path_book(book.name)) || raise(Exceptions::Books::NameExists.new(book.name))
          FileUtils.mkdir_p(Helpers::Enum.full_path_book(book.name))
          puts "SUCESS: Aceptado y creado" 
        rescue =>e
            puts e
        end

      def self.delete(book)
          Dir.exists?(Helpers::Enum.full_path_book(book.name)) || raise(Exceptions::Books::Generico.new('DELETE BOOK', "El libro #{book.name_upcase} no se encontro"))
          FileUtils.rm_rf(Helpers::Enum.full_path_book(book.name))
          puts "[Sucess:] El #{book.to_s} fue borrado"
        rescue => e
          puts e
      end
      def self.notes(book)
      end
      def self.all
        (Book.books_whitout_global).each do |num|
          puts "--> "+num
        end
      end
      def self.rename(old_name, new_name)
        begin
          old_name.downcase != "global" || raise(Exceptions::Books::Generico.new('RENAME GLOBAL', "El libro #{old_name} no se puede renombrar"))
        rescue => e
          puts e
          exit
        end
        begin 
        File.rename(Helpers::Enum.full_path_book(old_name), Helpers::Enum.full_path_book(new_name)) 
        rescue Errno::ENOTEMPTY
          raise(Exceptions::Books::Generico.new('RENAME', "[ERROR:] verifique que el nuevo nombre no exista")) 
          rescue => e
            puts e.to_s
        end
      end

      private 
      def self.books_whitout_global
        Dir.entries(Helpers::Enum::PATH).reject {|x| x =~ /global|[\W]/ }
      end
    end
  end
end