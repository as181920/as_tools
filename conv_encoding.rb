require "iconv"
require "charguess"

def check_usage
  unless ARGV.length >= 1 then
    puts <<-USAGE
Usage: ruby conv_encoding.rb filename
Examples: ruby conv_encoding.rb abc.txt
Output: converted.v
USAGE
  end
end

def infile_read(filename)
  input_str = IO.read(filename)
end

def outfile_write(filename,output_str)
  outfile_name = filename+".converted"
  outfile = File.open(outfile_name,"w")
  outfile.print output_str
  outfile.close
  print "output file:",outfile_name,"\n"
end

def convert
  ARGV.each do |f|
    print "convert file:",f,"\n"
    input = infile_read(f)
    input_encoding = CharGuess::guess(input) || "latin1"
    print "input encoding is:",input_encoding,"\n"
    output_encoding = "utf-8"
    print "output encoding is:utf-8 \n"
    converted_str = Iconv.new(output_encoding,input_encoding).iconv(input)
    outfile_write(f,converted_str)
  end
end

if $0 == __FILE__ then
  check_usage
  convert
end
