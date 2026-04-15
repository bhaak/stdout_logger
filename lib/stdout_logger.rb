require 'logger'
require 'pathname'
require "stdout_logger/version"

class StdoutLogger < Logger
  Format = "%s %5s -- %s: %s\n".freeze
  ColorFormat = "\033[0;37m%s \033[%sm%5s\033[0m -- %s: %s\n".freeze

  SEVERITY_TO_COLOR_MAP = {'DEBUG'=>'0;37', 'INFO'=>'32', 'WARN'=>'33', 'ERROR'=>'31', 'FATAL'=>'31', 'UNKNOWN'=>'37'}

  def set_encoding *args; end

  def initialize(*targets)
    formatter = proc do |severity, datetime, progname, msg|
      formatted_datetime = datetime.strftime("%Y-%m-%d %H:%M:%S")
      Format % [formatted_datetime, severity, progname, msg]
    end
    color_formatter = proc do |severity, datetime, progname, msg|
      color = SEVERITY_TO_COLOR_MAP[severity]
      formatted_datetime = datetime.strftime("%Y-%m-%d %H:%M:%S")
      ColorFormat % [formatted_datetime, color, severity, progname, msg]
    end

    @logger1 = Logger.new(STDOUT)
    logfile = "#{File.basename($0, ".*")}.log"
    logdirectory = Pathname("log").writable? ? "log" : "."
    @logger2 = Logger.new(File.join(logdirectory, logfile), 'daily')

    @logger1.formatter = STDOUT.tty? ? color_formatter : formatter
    @logger2.formatter = formatter
  end

  def write(args)
    @logger1.info args.strip unless args.nil? || args.strip == ""
    @logger2.info args.strip unless args.nil? || args.strip == ""
  end

  def flush
    # ignored
  end

  def close
    @logger1.close
    @logger2.close
  end

  def ioctl(*)
    # we don't support ioctl
    -1
  end

  def tty?
    false
  end
end

#if defined?(Pry) == 'constant' && Pry.class == Class
#  $stderr.puts 'stdout_logger not activated, Pry is loaded'
#  return
#end
$stdout = StdoutLogger.new
