require "logger"
require "RMagick"

$log=Logger.new(STDOUT)
$log.level = Logger::DEBUG
#$log.level = Logger::INFO

=begin
if ARGV.length != 1 then
  $log.fatal "use method: ruby jpg_adjust.rb directory_name!"
end

Dir.chdir(ARGV[0])
=end

def jpg_no_bigger_than(img,width,height)
  img.change_geometry("#{width}x#{height}") do |columns,rows,img|
    $log.debug "image size: rows:#{img.rows};columns:#{img.columns}"
    img.resize(columns,rows)
  end
end

files = Dir["*.jpg"]
files.each do |jpgfile|
  img=Magick::Image.read(jpgfile).first
  jpgnail=jpg_no_bigger_than(img,900,900)
  $log.debug "resized image size: rows:#{jpgnail.rows};columns:#{jpgnail.columns}"
  adjusted_jpgfile=jpgfile.gsub(/.jpg$/,".adjusted.jpg")
  jpgnail.write(adjusted_jpgfile)
end
