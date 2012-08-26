# encoding: utf-8
#require "rubygems"
require "RMagick"

imgs_dir = "/home/andersen/Downloads/xximg"
file_list = Dir.glob( imgs_dir+'/*.jpg') + Dir.glob( imgs_dir+'/*.png')

file_list.each do |imagefile|
  next if imagefile.to_s =~ /xinxian.jpg/
  next if File.exist? imagefile.to_s+".xinxian.jpg"
  print imagefile," to be composite...\n"
  dst = Magick::Image.read(File.dirname(__FILE__)+"/xx_background.jpg").first
  src = Magick::Image.read(imagefile).first.resize_to_fit(450,450)
  x_pos = (450 - src.columns)/2.0
  y_pos = (450 - src.rows)/2.0 + 50

  result = dst.composite(src, x_pos, y_pos, Magick::OverCompositeOp)
  #result = dst.composite(src, Magick::CenterGravity, Magick::OverCompositeOp)
  #result = dst.composite(src, Magick::SouthGravity, Magick::OverCompositeOp)
  result.write("#{imagefile}.xinxian.jpg")
end
=begin
=end
