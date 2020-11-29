require 'fileutils'
module DirHome
  def self.home
    @home ||= ("#{ENV['HOME']}/.my_rns")
  end
  def self.sucess
    FileUtils.mkdir_p(self.home) unless File.file?(FileUtils.pwd)
  end
  def self.path(name)
    self.home+"/"+name+"/"
  end


  def self.exists_dir?(name)
    Dir.exists?(self.home+"/"+name)
 
  end
  def self.before
    if !Dir.exists?(self.home+"/global") then 
      FileUtils.mkdir_p(self.home) unless File.file?(FileUtils.pwd)
      FileUtils.mkdir_p(self.home+"/"+"global") unless File.file?(FileUtils.pwd)
    end
  end
end
