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
          # begin 
          #se crea un objeto Book
          begin
          book = Models::Book.new(name)
          book.save
          rescue =>e
              puts e
          else
            puts "SUCESS: #{book}" 
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
          DirHome.before
          global = options[:global]
          #warn "TODO: Implementar borrado del cuaderno de notas con nombre '#{name}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          
          if !name.nil? && !name.strip.empty?
            Helpers::Book.delete(Models::Book.new(name)) 
          elsif global
              FileUtils.rm_rf(Dir.glob("#{Helpers::Enum::PATH_GLOBAL}/*"))
              puts "Sucess: Se limpio el libro GLOBAL"
          else
              puts "Requiere un argumento"
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
          puts DirHome.list.empty? ? 'No hay Libros creados' : 'Mis Libros:'
          Helpers::Book.all

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

          Helpers::Book.rename(old_name,new_name)
          
        end
      end
    end
  end
end
