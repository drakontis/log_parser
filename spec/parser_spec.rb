require 'spec_helper'

describe Parser do
  describe '#initialize' do
    it 'should create a new parser' do
      parser = Parser.new(log_file_path: 'spec/test_files/webserver.log')

      expect(parser.file_content).to eq "/help_page/1 126.318.035.038\n/contact 184.123.665.067\n/contact 184.123.665.067\n/contact 184.123.665.068"
    end
  end

  describe '#parse' do
    it 'should parse the file and print the results' do
      parser = Parser.new(log_file_path: 'spec/test_files/webserver.log')

      result = "> list of webpages with most page views ordered from most pages views to less page views\n"\
      "/contact 3 visits\n"\
      "/help_page/1 1 visits\n"\
      "-------------\n"\
      "> list of webpages with most unique page views also ordered\n"\
      "/contact 2 unique views\n"\
      "/help_page/1 1 unique views\n"

      expect{parser.parse}.to output(result).to_stdout
    end
  end

  describe '#print_results' do
    it 'should print the results' do
      entry_1 = LogEntry.new(page: '/example', ip: '127.0.0.1')
      entry_2 = LogEntry.new(page: '/example/2', ip: '127.0.0.2')
      entry_3 = LogEntry.new(page: '/example', ip: '127.0.0.3')
      entry_4 = LogEntry.new(page: '/example/2', ip: '127.0.0.2')
      entry_5 = LogEntry.new(page: '/example/2', ip: '127.0.0.2')

      log_entries = [entry_1, entry_2, entry_3, entry_4, entry_5]

      log = Log.new(entries: log_entries)

      parser = Parser.new(log_file_path: 'spec/test_files/webserver.log')

      result = "> list of webpages with most page views ordered from most pages views to less page views\n"\
      "/example/2 3 visits\n"\
      "/example 2 visits\n"\
      "-------------\n"\
      "> list of webpages with most unique page views also ordered\n"\
      "/example 2 unique views\n"\
      "/example/2 1 unique views\n"

      expect{parser.send(:print_results, log)}.to output(result).to_stdout
    end
  end

  describe '#create_log' do
    it 'should create a log' do
      parser = Parser.new(log_file_path: 'spec/test_files/webserver.log')
      log_entries = [LogEntry.new(page: '/example', ip: '127.0.0.1')]

      result = parser.send(:create_log, log_entries)
      expect(result).to be_a Log
      expect(result.entries).to eq log_entries
    end
  end

  describe '#log_entries_attributes_set' do
    it 'should return an array with the entries attributes' do
      parser = Parser.new(log_file_path: 'spec/test_files/webserver.log')

      result = parser.send(:log_entries_attributes_set)

      expect(result).to be_an Array
      expect(result.size).to eq 4

      first_result = result[0]
      expect(first_result).to be_an Array
      expect(first_result.size).to eq 2
      expect(first_result.first).to eq '/help_page/1'
      expect(first_result.last).to eq '126.318.035.038'

      second_result = result[1]
      expect(second_result).to be_an Array
      expect(second_result.size).to eq 2
      expect(second_result.first).to eq '/contact'
      expect(second_result.last).to eq '184.123.665.067'

      third_result = result[2]
      expect(third_result).to be_an Array
      expect(third_result.size).to eq 2
      expect(third_result.first).to eq '/contact'
      expect(third_result.last).to eq '184.123.665.067'

      fourth_result = result[3]
      expect(fourth_result).to be_an Array
      expect(fourth_result.size).to eq 2
      expect(fourth_result.first).to eq '/contact'
      expect(fourth_result.last).to eq '184.123.665.068'
    end
  end

  describe '#create_log_entries' do
    context 'with wrong file format' do
      it 'should raise error' do
        parser = Parser.new(log_file_path: 'spec/test_files/wrong_webserver.log')

        expect{parser.send(:create_log_entries)}.to raise_error ParseError
      end
    end

    context 'with empty file' do
      it 'should raise error' do
        parser = Parser.new(log_file_path: 'spec/test_files/empty_webserver.log')

        expect{parser.send(:create_log_entries)}.to raise_error ParseError
      end
    end

    context 'with correct log file' do
      it 'should return the log entries' do
        parser = Parser.new(log_file_path: 'spec/test_files/webserver.log')

        result = parser.send(:create_log_entries)
        expect(result).to be_an Array
        expect(result.count).to eq 4

        first_entry = result[0]
        expect(first_entry).to be_a LogEntry
        expect(first_entry.page).to eq '/help_page/1'
        expect(first_entry.ip).to eq '126.318.035.038'

        second_entry = result[1]
        expect(second_entry).to be_a LogEntry
        expect(second_entry.page).to eq '/contact'
        expect(second_entry.ip).to eq '184.123.665.067'

        third_entry = result[2]
        expect(third_entry).to be_a LogEntry
        expect(third_entry.page).to eq '/contact'
        expect(third_entry.ip).to eq '184.123.665.067'

        fourth_entry = result[3]
        expect(fourth_entry).to be_a LogEntry
        expect(fourth_entry.page).to eq '/contact'
        expect(fourth_entry.ip).to eq '184.123.665.068'
      end
    end
  end
end
