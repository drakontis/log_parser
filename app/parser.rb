require_relative 'log'
require_relative 'log_entry'
require_relative 'parse_error'

class Parser
  attr_reader :file_content

  def initialize(log_file_path:)
    @file_content = File.read(log_file_path)
  end

  def parse
    log_entries = create_log_entries
    log = create_log(log_entries)
    print_results(log)
  end

  #######
  private
  #######

  def create_log(log_entries)
    Log.new(entries: log_entries)
  end

  def create_log_entries
    log_entries = []

    raise ParseError.new('Empty Log File') if log_entries_attributes_set.empty?

    log_entries_attributes_set.each do |attributes_set|
      if attributes_set.size == 2
        log_entries << LogEntry.new(page: attributes_set.first, ip: attributes_set.last)
      else
        raise ParseError.new('Wrong File Format')
      end
    end

    log_entries
  end

  def log_entries_attributes_set
    file_content.split("\n").map{ |line| line.split(' ') }
  end

  def print_results(log)
    puts '> list of webpages with most page views ordered from most pages views to less page views'
    log.views_per_page.each do |views|
      puts "#{views.first} #{views.last.count} visits"
    end

    puts '-------------'

    puts '> list of webpages with most unique page views also ordered'
    log.unique_views_per_page.each do |views|
      puts "#{views.first} #{views.last.count} unique views"
    end
  end
end