require 'rspec'
require 'tempfile'
require 'pry'
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

  describe '.convert_line_to_token_array' do
    subject { described_class.new(file.path).convert_line_to_token_array(test_line) }

    context 'a class def' do
      let(:test_line) { 'class Main {' }
      it { expect(subject).to eq(%w[class Main {]) }
    end

    context 'a method call' do
      let(:test_line) { 'let length = Keyboard.readInt("HOW MANY NUMBERS? ");' }

      it { expect(subject).to eq(%w[let length = Keyboard . readInt ( "HOW\ MANY\ NUMBERS?\ " ) ;]) }
    end

    context 'a while loop' do
      let(:test_line) { 'while (i < length) {' }

      it { expect(subject).to eq(%w[while ( i < length ) {]) }
    end

    context 'a do statement' do
      let(:test_line) { 'do Output.printInt(sum / length);' }

      it { expect(subject).to eq(%w[do Output . printInt ( sum / length ) ;]) }
    end
  end

  describe '.get_token_type' do
    subject { described_class.new(file.path).get_token_type(test_token) }

    context 'when token is a keywaord' do
      let(:test_token) { 'constructor' }
      it { expect(subject).to eq('keyword') }
    end

    context 'when token is a symbol' do
      let(:test_token) { '[' }
      it { expect(subject).to eq('symbol') }
    end

    context 'when token is an identifier' do
      let(:test_token) { 'some_variable' }
      it { expect(subject).to eq('identifier') }
    end

    context 'when token is a string const' do
      let(:test_token) { '"WILL THIS WORK? "' }
      it { expect(subject).to eq('string_const') }
    end

    context 'when token is an integer const' do
      let(:test_token) { '421' }
      it { expect(subject).to eq('int_const') }
    end

    # matching might be imperfect, testing happy case only
    context 'when token does not belong to any known patter' do
      let(:test_token) { '941_saklg' }
      it { expect { subject }.to raise_error(JackTokenizer::UnexpectedToken) }
    end
  end
end
