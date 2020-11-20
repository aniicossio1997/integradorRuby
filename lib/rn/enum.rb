module RN
  module Enum
    PATH = (ENV['HOME']+"/.my_rns")
    PATH_GLOBAL=PATH+"/global/"
    GLOBAL = "global"

    def self.title_with_global(title)
      Enum::PATH_GLOBAL+title+".rn"
    end
  end
end