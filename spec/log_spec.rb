require 'spec_helper'

describe Log do
  describe '#initialize' do
    it 'should create a new log' do
      entry_1 = LogEntry.new(page: '/example', ip: '127.0.0.1')
      entry_2 = LogEntry.new(page: '/exmaple/2', ip: '127.0.0.1')
      log_entries = [entry_1, entry_2]

      log = Log.new(entries: log_entries)

      expect(log).to be_a Log
      expect(log.entries.size).to eq 2
      expect(log.entries.first).to eq entry_1
      expect(log.entries.last).to eq entry_2
    end
  end

  describe '#entries <<' do
    it 'should add entries to log' do
      log_entry = LogEntry.new(page: '/example', ip: '127.0.0.1')

      subject.entries << log_entry
      expect(subject.entries).to be_an Array
      expect(subject.entries.count).to eq 1
      expect(subject.entries.first).to eq log_entry
    end
  end
end
