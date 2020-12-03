require 'github/markup'

module RN
  module Models
    class Note
      include RN::Helpers
      include Helpers::Enum
      
      attr_accessor :book
      attr_reader :content
      attr_reader :title
      def initialize(title,book,content='')
        (!title.nil? && !title.strip.empty?)  || raise("[ERROR:] el titulo de la nota no puede ser un vacio")
        @book = (book.nil? ? Models::Book.new("global") : Models::Book.new(book))
        @content = content
        @title = self.sanitizer_string(title)
      end
      def to_s
        "nota: #{title}"
      end
      def path_full
        "#{book.path}/#{title}.rn"
      end
      def path
        book.path
      end
      def save
        Dir.exists?(self.path) || raise(Exceptions::Books::NotFound.new(self.book))
        !File.file?(self.path_full) || raise(Exceptions::Notes::Exists.new(self))
        FileUtils.touch(self.path_full)
      end
      def delete
        Dir.exists?(self.path) || raise(Exceptions::Books::NotFound.new(self.book))
        File.delete(self.path_full)
      end
      def retitle(new_title)
        self.persists?
        !book.exists_note?(new_title)  || raise(Exceptions::Notes::Exists.new(Note.new(new_title,book.name)))      
        File.rename(self.path_full, "#{book.path}/#{new_title}.rn")
      end
      def self.all_notes
        Models::Book.all_notes
      end
      def edit
        self.persists?
        editor = TTY::Editor.new(prompt: "Which one do you fancy?")
        editor.open(self.path_full)
      end
      def show
        self.persists?
        (!self.empty?) || raise("#{title} esta vacio")
        puts File.read(self.path_full) ,:rainbow
      end
      
      def persists?
        Dir.exists?(self.path) || raise(Exceptions::Books::NotFound.new(self.book))
        File.file?(self.path_full) || raise(Exceptions::Notes::Error.new("La #{self} no existe en #{book}"))
      end
      def empty?
        File.zero?(self.path_full)
      end
      def path_full_changed_html
        "#{book.path}/#{title}_#{book.name}.html"
      end
      def path_all_html
        "#{PATH}/#{title}_#{book.name}.html"
      end
      
      def report(actual_book=nil)
        self.persists?
        actual_book = actual_book.nil? ? (self.path_full_changed_html) : (self.path_all_html)
        # `"#{MD2html}" "#{self.path_full}" "#{actual_book}"`
        contents_html=GitHub::Markup.render_s(GitHub::Markups::MARKUP_MARKDOWN,self.content)
        File.write(actual_book, contents_html)
      end
      
      def content
        File.read(self.path_full)
      end

    end
  end
end
