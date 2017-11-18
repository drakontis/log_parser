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

  describe '#views_per_page' do
    it 'should return the ordered views per page' do
      entry_1 = LogEntry.new(page: '/example', ip: '127.0.0.1')
      entry_2 = LogEntry.new(page: '/example/2', ip: '127.0.0.2')
      entry_3 = LogEntry.new(page: '/example', ip: '127.0.0.3')
      entry_4 = LogEntry.new(page: '/example/2', ip: '127.0.0.4')
      entry_5 = LogEntry.new(page: '/example/2', ip: '127.0.0.5')

      log_entries = [entry_1, entry_2, entry_3, entry_4, entry_5]

      result = Log.new(entries: log_entries).views_per_page

      expect(result).to be_an Array

      first_element = result.first
      expect(first_element.first).to eq '/example/2'
      expect(first_element.last.count).to eq 3

      second_element = result.last
      expect(second_element.first).to eq '/example'
      expect(second_element.last.count).to eq 2
    end
  end

  describe '#unique_views_per_page' do
    it 'should return the ordered views per page' do
      entry_1 = LogEntry.new(page: '/example', ip: '127.0.0.1')
      entry_2 = LogEntry.new(page: '/example/2', ip: '127.0.0.2')
      entry_3 = LogEntry.new(page: '/example', ip: '127.0.0.3')
      entry_4 = LogEntry.new(page: '/example/2', ip: '127.0.0.2')
      entry_5 = LogEntry.new(page: '/example/2', ip: '127.0.0.2')
      entry_6 = LogEntry.new(page: '/example', ip: '127.0.0.2')
      entry_7 = LogEntry.new(page: '/example', ip: '127.0.0.2')

      log_entries = [entry_1, entry_2, entry_3, entry_4, entry_5, entry_6, entry_7]

      result = Log.new(entries: log_entries).unique_views_per_page

      expect(result).to be_an Array

      first_element = result.first
      expect(first_element.first).to eq '/example'
      expect(first_element.last.count).to eq 3

      second_element = result.last
      expect(second_element.first).to eq '/example/2'
      expect(second_element.last.count).to eq 1
    end
  end
end
