require 'open-uri'
require 'digest/sha1'
 
class RemoteFile < ::Tempfile
 
  def initialize(path, tmpdir = Dir::tmpdir)
    @original_filename  = File.basename(path).parameterize
    @remote_path        = path
 
    super Digest::SHA1.hexdigest(path), tmpdir
    fetch
  end
 
  def fetch
    begin
      string_io = OpenURI.send(:open, @remote_path)
      self.write string_io.read
      self.rewind
      self
    rescue Exception => e
      puts e
    end
  end
 
  def original_filename
    @original_filename
  end
 
  def content_type
    mime = `file --mime -br #{self.path}`.strip
    mime = mime.gsub(/^.*: */,"")
    mime = mime.gsub(/;.*$/,"")
    mime = mime.gsub(/,.*$/,"")
    mime
  end
end