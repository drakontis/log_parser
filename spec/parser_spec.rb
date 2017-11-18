require 'spec_helper'

describe Parser do
  describe '#initialize' do
    it 'should create a new parser' do
      parser = Parser.new(log_file_path: 'spec/test_files/webserver.log')

      expect(parser.file_content).to eq "/help_page/1 126.318.035.038\n/contact 184.123.665.067\n/home 184.123.665.067"
    end
  end
end
