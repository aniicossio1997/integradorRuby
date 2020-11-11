module ModuleFile
  def self.create(file_name)
    file_name = DirHome.home
    unless File.exist?(File.dirname(DirHome.file_name))
        FileUtils.mkdir_p(File.dirname(DirHome.file_name))
    end
  end
end 