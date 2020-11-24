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

  def self.list
    #((Dir.entries(self.home)).delete_if{ |each| !!(each =~/[\W]/)})
    #Dir.entries(self.home).delete_if{ |each| !!(each =~(/global|[\W]/))}
    #`ls $HOME/.my_rns`. split("\n").reject {|x| x =~ /global/ }
   Dir.entries(self.home).reject {|x| x =~ /global|[\W]/ }
  end
  #def self.create_dir(name)
  #  (FileUtils.mkdir_p(self.home+"/"+name)) unless File.file?(FileUtils.pwd)
  #end
  def self.exists_dir?(name)
    Dir.exists?(self.home+"/"+name)
    #Dir.exists?(ENV['HOME']+"/.my_rns"+"/"+name)
  end
  def self.before
    if !Dir.exists?(self.home+"/global") then 
      FileUtils.mkdir_p(self.home) unless File.file?(FileUtils.pwd)
      FileUtils.mkdir_p(self.home+"/"+"global") unless File.file?(FileUtils.pwd)
    end
  end
end
