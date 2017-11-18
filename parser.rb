require './app/parser'

##
# Usage:
# ruby parser.rb 'logs/webserver.log'
#
Parser.new(log_file_path: ARGV[0]).parse