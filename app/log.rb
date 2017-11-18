class Log
  attr_accessor :entries

  def initialize(entries:)
    @entries = entries
  end

  def views_per_page
    entries.group_by{ |entry| entry.page }.to_a.sort_by{ |obj| -obj.last.count }
  end

  def unique_views_per_page
    entries.uniq{ |entry| entry.page && entry.ip }.group_by{ |entry| entry.page }.to_a.sort_by{ |obj| -obj.last.count }
  end
end