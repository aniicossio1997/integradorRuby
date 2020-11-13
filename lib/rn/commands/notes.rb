require 'tty-editor'
require 'colorputs'
module RN
  module Commands
    module Notes
      class Create < Dry::CLI::Command
        desc 'Create a note'
        include ModuleEnum
        include DirHome
        DirHome::before
        #include RN::ModuleFile
        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Creates a note titled "todo" in the global book',
          '"New note" --book "My book" # Creates a note titled "New note" in the book "My book"',
          'thoughts --book Memoires    # Creates a note titled "thoughts" in the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          title = title.downcase
          
          #warn "TODO: Implementar creación de la nota con título '#{title}' (en el libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
             
          if !(title =~/\W/) then
            puts "cumple con el formato"
            #puts File.directory?(DirHome::path(book))
            #puts DirHome::exists_dir?(book)
            if !book.nil? then
              puts DirHome::exists_dir?(book)
              begin
                true
                puts "never get here"
              rescue SystemExit
                puts "rescued a SystemExit exception"
              end

            else
              puts "para la carpeta global"
              #puts ModuleEnum::PATH_GLOBAL+title+".rn"
              #puts File.file?(ModuleEnum::PATH_GLOBAL+title+".rn")
              if !File.file?(ModuleEnum::PATH_GLOBAL+title+".rn") then
                File.new(ModuleEnum::PATH_GLOBAL+title+".rn", "a")
                puts "La nota #{title} se creo en el libro GLOBAL"
              else
                puts "#{title.upcase} ya existe en la carpeta GLOBAL"
              end 
            end
            
          else
            puts "El titulo -- #{title} -- no cumple con el formato"
          end
          puts "sali.."
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a note'
        #include ModuleFile

        
        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Deletes a note titled "todo" from the global book',
          '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          result= if File.file?(ModuleEnum::PATH_GLOBAL+title+".rn") then File.delete(ModuleEnum::PATH_GLOBAL+title+".rn") end
          if result== 1 then
            puts "La nota se elimino correctamente"
          else
            puts "No se pudo eliminar, la nota puede no existir"
          end
          #warn "TODO: Implementar borrado de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Edits a note titled "todo" from the global book',
          '"New note" --book "My book" # Edits a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Edits a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          #warn "TODO: Implementar modificación de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          if File.file?(ModuleEnum::PATH_GLOBAL+title+".rn") then
            TTY::Editor.open(ModuleEnum::PATH_GLOBAL+title+".rn")
            puts File.read(ModuleEnum::PATH_GLOBAL+title+".rn") ,rainbow
          end
          puts "ERROR: verifique el titulo"
        end
      end

      class Retitle < Dry::CLI::Command
        desc 'Retitle a note'

        argument :old_title, required: true, desc: 'Current title of the note'
        argument :new_title, required: true, desc: 'New title for the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo TODO                                 # Changes the title of the note titled "todo" from the global book to "TODO"',
          '"New note" "Just a note" --book "My book" # Changes the title of the note titled "New note" from the book "My book" to "Just a note"',
          'thoughts thinking --book Memoires         # Changes the title of the note titled "thoughts" from the book "Memoires" to "thinking"'
        ]

        def call(old_title:, new_title:, **options)
          book = options[:book]
          #warn "TODO: Implementar cambio del título de la nota con título '#{old_title}' hacia '#{new_title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          
        end
      end

      class List < Dry::CLI::Command
        desc 'List notes'

        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, default: false, desc: 'List only notes from the global book'

        example [
          '                 # Lists notes from all books (including the global book)',
          '--global         # Lists notes from the global book',
          '--book "My book" # Lists notes from the book named "My book"',
          '--book Memoires  # Lists notes from the book named "Memoires"'
        ]

        def call(**options)
          book = options[:book]
          global = options[:global]
          warn "TODO: Implementar listado de las notas del libro '#{book}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Show < Dry::CLI::Command
        desc 'Show a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Shows a note titled "todo" from the global book',
          '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          warn "TODO: Implementar vista de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end
