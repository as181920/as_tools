# copy from http://wiki.openqa.org/display/WTR/Re-Usable+Load+Testing+Example and modified by Anderesn_Fan
# Runs given +testScript(s)+ for +numIterations+ using +numUsers+ with a delay of +delayBetweenUsers+
# +testScript+ should be the full path of a test script.

require 'thread'
require 'yaml'
require 'precheck'
require 'logger'

$LOG = Logger.new(STDOUT)
$LOG.level = Logger::DEBUG
$CONFIG = YAML.load(File.read(Dir.getwd+"/"+"conf_LoadTester.yml"))

class LoadTester
  def self.loadTestRunner
    (1..$CONFIG["numIterations"]).each do |iteration|
      $LOG.info("### Iteration #{iteration} begin.")
      threads = []
      $CONFIG["numUsers"].times do |i|
        ARGV.each do |file|
          threads << Thread.new do
            result = system("ruby #{file}")
            # result = system("ruby #{file} 1>/dev/null")
            unless result then
              $LOG.error("thread execution got error!")
            end
          end
        end
        # sleep $CONFIG["delayBetweenUsers"]
      end
      # puts Thread.list
      threads.each {|t| t.join}
      $LOG.info("### Iteration #{iteration} end.")
    end
  end
end

$LOG.info("###############################################################")
$LOG.info("########################## pre check ##########################")
$LOG.info("###############################################################")
PreCheck.check_all

$LOG.info("###############################################################")
$LOG.info("########################## executing ##########################")
$LOG.info("###############################################################")
# if $0 == __FILE__ then
# end
LoadTester.loadTestRunner

$LOG.info("###############################################################")
$LOG.info("########################## completed ##########################")
$LOG.info("###############################################################")

