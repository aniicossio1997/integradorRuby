module RN
  module ModuleFile
    #include RN::COMMANDS::ModuleEnum
    # def self.name_with_extend(title)
    #   puts PATH_GLOBAL+title+".rn"
    #   puts title
    # end
    DATO= "hola"
    def self.create(object)
      
      puts "soy la clase #{object.class}"
      puts object.to_s
    end
    def self.create_file(title, module_dir_homes)
      # No need .fetch to do cool stuff
      if !(title =~/\W/) 
        puts "acept"
      end
      puts title
      puts module_dir_homes.home
    end
  end 
end