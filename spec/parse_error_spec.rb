require 'spec_helper'

describe ParseError do
  it 'should inherit from RuntimeError' do
    expect(ParseError).to be < RuntimeError
  end

  describe '#initialize' do
    it 'should create a new parse error' do
      parse_error = ParseError.new('test error')

      expect(parse_error).to be_a ParseError
    end
  end
end
