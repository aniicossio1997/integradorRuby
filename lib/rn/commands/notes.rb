require 'tty-editor'
require 'colorputs'
module RN
  module Commands
    module Notes
      class Create < Dry::CLI::Command
        desc 'Create a note'
        
        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Creates a note titled "todo" in the global book',
          '"New note" --book "My book" # Creates a note titled "New note" in the book "My book"',
          'thoughts --book Memoires    # Creates a note titled "thoughts" in the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          #title = title.downcase
          #puts title.strip
          #warn "TODO: Implementar creación de la nota con título '#{title}' (en el libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          puts 
          if title.strip.empty?
            puts 'Debe ingresar un titulo de nota no vacío'
          else
            note=Models::Note.new(title,book)
            begin
              note.save
            rescue Exceptions::Notes::Exists => e
              puts e
            rescue Exceptions::Books::NotFound => e
              puts e
            else
             puts "se crea la #{note} en el #{note.book}"
            end
          end
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Deletes a note titled "todo" from the global book',
          '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]

          note=Models::Note.new(title,book)
          begin
            note.delete
          rescue Exceptions::Books::NotFound => e
            puts e
          rescue Errno::ENOENT =>e
            puts "[ERROR NOTE:] EL #{note.book} no tiene a #{note}"
          else
            puts "[Sucess] Eliminación de #{note} completada"
          end

          #warn "TODO: Implementar borrado de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Edit < Dry::CLI::Command
        include TTY::Color
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
          note = Models::Note.new(title,book)
          begin
            note.edit
          rescue Exceptions::Notes::Error => e
            puts e
          rescue Exceptions::Books::NotFound => e
            puts e
          else
            "se edito correctamente"
          end
          
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
          new_title = Helpers::Sanitizer.string(new_title)
          #warn "TODO: Implementar cambio del título de la nota con título '#{old_title}' hacia '#{new_title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          note=Models::Note.new(old_title,book)
          begin
            note.retitle(new_title)
          rescue Exceptions::Books::NotFound => e
            puts e
          rescue Errno::ENOENT =>e
            puts "[ERROR NOTE:] EL #{note.book} no tiene a #{note}"
          rescue => e
            puts e
          else
            puts "[Sucess] se renombro -- #{old_title} -- con -- #{new_title} -- "
          end
        end
      end

      class List < Dry::CLI::Command
        desc 'List notes'
        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, default: false, desc: 'List only notes from the global book'
        #option :all, type: :string, desc: 'All'
        example [
          '                 # Lists notes from all books (including the global book)',
          '--global         # Lists notes from the global book',
          '--book "My book" # Lists notes from the book named "My book"',
          '--book Memoires  # Lists notes from the book named "Memoires"'
        ]

        def call(**options)
          book = options[:book]
          global = options[:global]
          #warn "TODO: Implementar listado de las notas del libro '#{book}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          option= option = global  ? 'global' : (book.nil? ? 'all' : book)
        
          if option == "all"
            notes= Models::Note.all_notes
            msj= notes.empty? ? 'No hay notas' : 'Todas las notas:'
            puts "#{msj} \n#{(notes)}\n"
          else
            begin
              other_book= Models::Book.new(option)
              if other_book.notes.empty?
                puts "no hay notas en esa carpeta"
              end
              puts "#{(other_book.notes)}"
            rescue Exceptions::Books::NotFound => e
              puts e
            end
          end

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
          note= Models::Note.new(title,book)
          begin
            note.show
          rescue Exceptions::Notes::Error => e
            puts e
          rescue Exceptions::Books::NotFound => e
            puts e
          rescue => e 
              puts e
          end
          #warn "TODO: Implementar vista de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end


      class Report < Dry::CLI::Command
        desc 'report notes'

        argument :title, required: true, desc: 'Title of the note'        
        option :book, type: :string, desc: 'Book'
        
        #option :all, type: :string, desc: 'All'
        example [
            '"file" --book "My book" #report the note "file"  from the book "My book" '
        ]

        # – Una nota en particular. --book "title"
        # – Todas las notas de un cuaderno en particular.
        # – Todas las notas presentes en todos los cuadernos del cajón de notas.
        
        def call(title:, **options)
          book = options[:book]
          #all = options[:all]
          #warn "TODO: Implementar listado de las notas del libro '#{book}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          #option= option = global  ? 'global' : (book.nil? ? 'all' : book)
          #option= !book.nil? ? book : 'global' 
          if !book.nil? && !title.nil?
            note=Models::Note.new(title,book)
            puts "reporte de una en un libro que no sea el global"
          elsif(book.nil? && !title.nil?)
            puts "repote de una nota de la carpeta global"
          else
            puts "[ERROR:] requiere un argumento valido"
          end

        end
      end

    end
  end
end
