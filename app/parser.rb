require_relative 'log'
require_relative 'log_entry'

class Parser
  attr_reader :file_content

  def initialize(log_file_path:)
    @file_content = File.read(log_file_path)
  end
end