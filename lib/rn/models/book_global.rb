require 'rn/models/book'
module RN
  module Models
    class BookGlobal < Models::Book

      def initialize (name="global")
        @name = Helpers::Sanitizer.string(name)        
      end

      def delete
        # Dir.exists?(self.path) || raise(Exceptions::Books::Generico.new('DELETE', "El #{self} no se encontro"))
        FileUtils.rm_rf(Dir.glob("#{self.path}/*"))
      end

    end
  end
end