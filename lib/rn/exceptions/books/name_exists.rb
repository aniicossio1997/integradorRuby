module RN
  module Exceptions
    module Book
      class NameExists< StandardError
        def initialize(name,msj="ERROR: El nombre del libro ya existe #{name}")
          #"[#{explicit ? 'EXPLICIT' : 'INEXPLICIT'}] #{exception.class}: #{exception.message}"
          super(msj)
      end
    end
  end
end