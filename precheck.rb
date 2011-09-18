require 'logger'
$LOG = Logger.new(STDOUT)
$LOG.level = Logger::DEBUG

class PreCheck
  def self.check_all
    check_ARGV_available
    check_file_exists
    check_rb_syntax
    scripts = []
    ARGV.each do |f|
      scripts << f
    end
    $LOG.info("#{ARGV.length} script file\(s\) will be executed: #{scripts}")
  end

  private
  def self.check_ARGV_available
    unless ARGV.length >= 1 then
      $LOG.fatal("no file to be excetued!")
      puts <<-USAGE
Usage: ruby LoadTester.rb script1.rb scriptn.rb
Examples: ruby LoadTester.rb test.rb
USAGE
      exit
    end
  end

  def self.check_file_exists
    ARGV.each do |f|
      unless File.readable? f then
        $LOG.fatal("file not exist or permission denied: [#{f}]")
        exit
      end
    end
  end

  def self.check_rb_syntax
    ARGV.each do |f|
      #unless system("ruby -c #{f} 1>/dev/null") then
      unless system("ruby -c #{f}") then
        $LOG.fatal("found syntax error during file: [#{f}]")
        exit
      end
    end
  end
end

