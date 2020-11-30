#require 'dry/cli/utils/files'
module RN
  module Commands
    module Books
      class Create < Dry::CLI::Command
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
          
          book = Models::Book.new(name)
          begin
            book.save
          rescue Exceptions::Books::NameExists => e
              puts e
          else
            puts "[SUCESS:] se creo #{book}" 
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
          global = options[:global]
          #warn "TODO: Implementar borrado del cuaderno de notas con nombre '#{name}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          # aux = (!name.nil? && !global) ? name : ((global && name.nil?) ? 'global' : 'exit')
          # puts aux
          if !name.nil? && !name.strip.empty? && !global
            begin
              book=Models::Book.new(name)
              book.delete
            rescue Exceptions::Books::Generico => e
              puts e
            else
              puts "se elimino el #{book}"
            end
          elsif (global && name.nil?)
              book= Models::BookGlobal.new
              book.delete
              puts "Sucess: Se limpio el libro GLOBAL"
          else
              puts "Requiere un argumento valido"
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
          puts Models::Book.books_whitout_global.empty? ? 'No hay Libros creados' : '[Mis Libros:] '
          puts Models::Book.books_whitout_global

        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a book'

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        example [
          '"My book" "Our book"         # Renames the book "My book" to "Our book"',
          'Memoires Memories            # Renames the book "Memoires" to "Memories"',
          '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
        ]

        def call(old_name:, new_name:, **)
          #warn "TODO: Implementar renombrado del cuaderno de notas con nombre '#{old_name}' para que pase a llamarse '#{new_name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          old_book= Models::Book.new(old_name)
          new_book= Models::Book.new(new_name)
          begin
            old_book.rename(new_book)          
          rescue Errno::ENOTEMPTY
            puts "[ERROR:] No se puede renombrar con el nombre #{new_book.name} YA EXISTENTE dicho libro"
          rescue Errno::ENOENT
            puts "[ERROR:] no se encontro el #{old_book}"
          rescue => e
            puts e
          else
            puts "[SUCESS:] Se renombro #{old_book} por el #{new_book}"
          end
          
        end
      end
    end
  end
end
