require 'spec_helper'

describe LogEntry do
  describe '#initialize' do
    it 'should create a new log_entry' do
      page = '/example'
      ip = '127.0.0.1'
      log_entry = LogEntry.new(page: page, ip: ip)

      expect(log_entry).to be_a LogEntry
      expect(log_entry.page).to eq page
      expect(log_entry.ip).to eq ip
    end
  end
end
