module RN
  module Helpers
    module Enum
      PATH = (ENV['HOME']+"/.my_rns")
      PATH_GLOBAL=PATH+"/global/"
      GLOBAL = "global"

      def self.title_with_global(title)
        Enum::PATH_GLOBAL+title+".rn"
      end
      def self.full_path_book(string)
        Enum::PATH+"/#{string}"
      end
      # def self.full_path_note(title,book_name)

      # end
    end
end
end