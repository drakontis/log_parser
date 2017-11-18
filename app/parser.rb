require_relative 'log'
require_relative 'log_entry'
require_relative 'parse_error'

class Parser
  attr_reader :file_content

  def initialize(log_file_path:)
    @file_content = File.read(log_file_path)
  end
end