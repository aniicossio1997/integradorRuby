require "active_support/concern"
require 'rubygems'
require 'zip'
module Download
  extend ActiveSupport::Concern
  
  def to_html(name_book="all",notes)
    
    FileUtils.mkdir_p("tmp/#{current_user.id}")
    FileUtils.mkdir_p("tmp/#{current_user.id}/#{name_book}")

    zipfile = Zip::File.open("tmp/#{current_user.id}.zip", Zip::File::CREATE)
    zipfile.mkdir("#{name_book}")
    notes.each do |note|
        File.write("tmp/#{current_user.id}/#{name_book}/#{note.title_for_download}.html",note.markdown)
        zipfile.add("#{name_book}/#{note.title_for_download}.html", "tmp/#{current_user.id}/#{name_book}/#{note.title_for_download}.html" )
    end
    zipfile.close
    (Dir.new("tmp/#{current_user.id}/#{name_book}")).children().map{|d| File.delete("tmp/#{current_user.id}/#{name_book}/#{d}")}
    Dir.rmdir("tmp/#{current_user.id}/#{name_book}")
    Dir.rmdir("tmp/#{current_user.id}/")
    send_data(File.read("tmp/#{current_user.id}.zip"), filename: "#{name_book}.zip", type: 'application/zip' )
    File.delete("tmp/#{current_user.id}.zip")
  end

end