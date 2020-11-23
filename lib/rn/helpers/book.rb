module RN
  module Helpers
    class Book
      def self.create(book)

        puts "estoy en #{self}"
        raise StandardError.new "This is an exception"
          # if !(DirHome.exists_dir?(name)))
          #   name = name.downcase
          #   result=FileUtils.mkdir_p(DirHome.home+"/"+name) unless File.file?(FileUtils.pwd)
          #   #File.new(DirHome.home+"/"+name+".rn", "a")
          #   puts "SUCESS: Aceptado y creado"
          # else
          #   puts "WRONG:", "Lo sentimos el nombre no cumple con el formato establecido o", "el directorio existe"
          # end
      end
    end
  end
end