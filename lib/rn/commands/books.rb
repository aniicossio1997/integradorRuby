#require 'dry/cli/utils/files'
module RN
  module Commands
    module Books
      class Create < Dry::CLI::Command
        include DirHome
        desc 'Create a book'
        

        argument :name, required: true, desc: 'Name of the book'

        example [
          #'"My book" # Creates a new book named "My book"',
          #'Memoires  # Creates a new book named "Memoires"'
         
        ]
        
      
        def call(name:, **)
          #warn "TODO: Implementar creación del cuaderno de notas con nombre '#{name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          #puts "crea .... fin"+DirHome.home
          puts "Recuerde que el nombre no debe contener caracteres especiales, espacios, y puntuaciones"
          puts name
          if (!!(name =~/[\w]/) && !(DirHome.exists_dir?(name))) then
            name = name.downcase
            result=FileUtils.mkdir_p(DirHome.home+"/"+name) unless File.file?(FileUtils.pwd)
            #File.new(DirHome.home+"/"+name+".rn", "a")
            puts "SUCESS: Aceptado y creado"
          else
            puts "WRONG: Lo sentimos el nombre no cumple con el formato establecido o el directorio existe"
          end

        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a book'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operate on the global book'

        example [
          '--global  # Deletes all notes from the global book',
          '"My book" # Deletes a book named "My book" and all of its notes',
          'Memoires  # Deletes a book named "Memoires" and all of its notes'
        ]

        def call(name: nil, **options)
          #global = options[:global]
          #warn "TODO: Implementar borrado del cuaderno de notas con nombre '#{name}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          DirHome.before
          name.downcase
          if DirHome.exists_dir?(name) then
            if name=="global" then
              FileUtils.rm_rf(Dir.glob(DirHome.path(name+"/*")))
            else 
              FileUtils.rm_rf(Dir.glob(DirHome.path(name)))
            end
            puts "SUCESS: eliminacion exitosa"
          else
            puts "WRONG: upps! no se encontro el archivo"
          end
        end
      end

      class List < Dry::CLI::Command
        desc 'List books'

        example [
          '          # Lists every available book'
        ]

        def call(*)
          #warn "TODO: Implementar listado de los cuadernos de notas.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          puts "Mis carpetas:"
         ## puts DirHome.list
          DirHome.list.each do |num|
            puts num
        end
        end
      end

      class Rename < Dry::CLI::Command
        include ModuleEnum
        desc 'Rename a book'

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        example [
          '"My book" "Our book"         # Renames the book "My book" to "Our book"',
          'Memoires Memories            # Renames the book "Memoires" to "Memories"',
          '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
        ]

        def call(old_name:, new_name:, **)
          DirHome.before
          #warn "TODO: Implementar renombrado del cuaderno de notas con nombre '#{old_name}' para que pase a llamarse '#{new_name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        
          if DirHome.exists_dir?(old_name) && old_name!=ModuleEnum::GLOBAL && new_name!=ModuleEnum::GLOBAL && !DirHome.exists_dir?(new_name)  then
            begin 
              File.rename(DirHome.path(old_name), DirHome.path(new_name)) 
            rescue Exception => e 
              # the exception your way
              puts "Exeption: la operacion fue interumpida"
            end
            puts "SUCESS: Rename a book"
          else
            puts "--WRONG:"
            puts "-GLOBAL no se puede renombrar"
            puts "-No puede haber nombres repetidos"
          end

        end
      end
    end
  end
end
