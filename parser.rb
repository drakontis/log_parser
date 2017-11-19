require './app/parser'

##
# Usage:
# ruby parser.rb 'logs/webserver.log'
#
begin
  Parser.new(log_file_path: ARGV[0]).parse
rescue => ex
  puts ex
end