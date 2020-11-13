module ModuleEnum
  PATH = (ENV['HOME']+"/.my_rns")
  PATH_GLOBAL=PATH+"/global/"
  GLOBAL = "global"

  def self.title_with_global(title)
    ModuleEnum::PATH_GLOBAL+title+".rn"
  end
end
