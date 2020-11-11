require 'fileutils'

module DirHome
  before: :DirHome.create_global
  def self.home
    @home=(ENV['HOME']+"/.my_rns")
  end
  def self.sucess
    FileUtils.mkdir_p(self.home) unless File.file?(FileUtils.pwd)
  end
  def self.path
    if self.sucess== 0 || self== nil then
       FileUtils.cd(self.home)
       return FileUtils.pwd
    else
      return "error"
    end
  end
  def self.file_exits(file_name)
    #self.sucess
     
     unless File.file?(File.dirname(file_name)) then
      self.sucess
     return  true
     else
      return false
     end
  end
  def self.pwd
    FileUtils.pwd
  end
  def self.list
    ((Dir.entries(self.home)).delete_if{ |each| !!(each =~/\W/)})
  end
  #def self.create_dir(name)
  #  (FileUtils.mkdir_p(self.home+"/"+name)) unless File.file?(FileUtils.pwd)
  #end
  private
  def self.create_global
    if !Dir.exists?(self.home+"/"+"global") then 
      FileUtils.mkdir_p(self.home) unless File.file?(FileUtils.pwd)
      FileUtils.mkdir_p(self.home+"/"+"global") unless File.file?(FileUtils.pwd)
    end
  end
end
