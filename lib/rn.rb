module RN
  autoload :VERSION, 'rn/version'
  autoload :Commands, 'rn/commands'
  autoload  :DirHome,  'rn/commands/DirHome'
  autoload  :ModuleEnum, 'rn/commands/ModuleEnum'
  autoload  :ModuleFile,  'rn/ModuleFile'
  # Agregar aquí cualquier autoload que sea necesario para que se cargue las clases y
  # módulos del modelo de datos.
  # Por ejemplo:
  # autoload :Note, 'rn/note'
end
