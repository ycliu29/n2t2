require 'rspec'
require 'tempfile'
require_relative 'JackTokenizer.rb'

RSpec.describe JackTokenizer do

  let(:file) { Tempfile.new('temp') } 
  
  describe '.remove_comments' do
    subject { described_class.new(file.path).remove_comments(test_array) } 

    let(:string_a) { "def test_method\r\n" }
    let(:string_b) { "a = a * a\r\rn" }
    let(:string_c) { "end\r\n" }
    let(:test_array) { [string_a, string_b, string_c] }

    context 'when there\'s no comment' do
      it do
        expect(subject).to eq(test_array)
      end
    end 

    context 'when there\'s \/\/ type of comment' do
      let(:comment_string) { "// this should be removed\r\n" }
      let(:test_array) { [string_a, string_b, string_c, comment_string] }

      it do
        result = subject
        test_array.pop()
        processed_array = test_array.append("\r\n")

        expect(result).to eq(processed_array)
      end

      context 'when \/\/ starts within line' do
        let(:comment_string) { "some code here // this should be removed\r\n" }
        let(:test_array) { [string_a, string_b, string_c, comment_string] }

        it do
          result = subject
          test_array.pop()
          processed_array = test_array.append("some code here \r\n")
  
          expect(result).to eq(processed_array)
        end
      end
    end

    context 'when there\'s \/\* type of comment' do
      let(:comment_string) { "place_holder /* this should be removed */\r\n" }
      let(:test_array) { [string_a, string_b, string_c, comment_string] }

      it do
        result = subject
        test_array.pop()
        processed_array = test_array.append("place_holder \r\n")

        expect(result).to eq(processed_array)
      end
    end

    context 'when there\'s \/\*\* type of comment' do
      let(:comment_string) { "place_holder /** this should be removed */\r\n" }
      let(:test_array) { [string_a, string_b, string_c, comment_string] }

      it do
        result = subject
        test_array.pop()
        processed_array = test_array.append("place_holder \r\n")

        expect(result).to eq(processed_array)
      end
    end
  end

  describe '.remove_crlf' do
    subject { described_class.new(file.path).remove_crlf(test_array) } 

    let(:string_a) { "def test_method\r\n" }
    let(:test_array) { [string_a] }

    context 'when strings contain other info' do
      it do
        expect(subject).to eq([ string_a.chomp! ])
      end
    end

    context 'when there are crlf only string' do
      let(:crlf_only_string) { "\r\n" } 

      it do
        result = subject
        expect(result).to eq([ string_a.chomp! ])
        expect(result).not_to include(crlf_only_string)
      end
    end
  end
end
