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
        old_book= Models::Book.new(old_name)
        new_book= Models::Book.new(new_name)
        begin
          (old_book.name != "global" ) || raise(Exceptions::Books::Generico.new('[ERROR RENAME GLOBAL]', "No se puede renombrar o utilizar GLOBAL"))
          File.rename(Helpers::Enum.full_path_book(old_book.name), Helpers::Enum.full_path_book(new_book.name)) 
        rescue Errno::ENOTEMPTY
          puts "[ERROR RENAME] No se puede renombrar con el nombre #{new_book.name} YA EXISTENTE dicho libro"
        rescue Errno::ENOENT
          puts "[ERROR RENAME] no se encontro el #{old_book}"
        rescue => e
          puts e
        else
          puts "[SUCESS:] Se renombro #{old_book} con #{new_book}"
        end

      end

      private 
      def self.books_whitout_global
        Dir.entries(Helpers::Enum::PATH).reject {|x| x =~ /global|[\W]/ }
      end
    end
  end
end