require 'rspec'
require 'pry'
require 'tempfile'
require_relative 'CompilationEngine.rb'

RSpec.describe CompilationEngine do
  subject { described_class.new(test_file) }

  describe '.peak' do
    let(:test_file) { Tempfile.new }
    let(:file_data) { "<symbol> . </symbol>\r\n<identifier> println </identifier>\r\n<symbol> ( </symbol>\r\n<symbol> ) </symbol>\r\n<symbol> ; </symbol>\r\n<keyword> return </keyword>\r\n</tokens>\r\n" }
    let!(:prepare_test_file) do
      file = File.open("#{test_file.path}", 'w')
      file.write(file_data)
      file.close
    end

    context 'when peaking a legit index' do
      context 'when it includes type and value' do
        let(:test_index) { 0 }
        it { expect(subject.peak(test_index)).to eq( { type: 'symbol', value: '.' } ) }
      end

      context 'when it only has type' do
        let(:test_index) { subject.tokens.length-1 }
        it { expect(subject.peak(test_index)).to eq( { type: 'tokens', value: nil } ) }
      end
    end

    context 'when peaking a negative index' do
      let(:test_index) { -10 }
      it { expect{subject.peak(test_index)}.to raise_error(CompilationEngine::IncorrectPeakIndex) }
    end

    context 'when peaking an out of range index' do
      let(:test_index) { 999 }
      it do
        expect(test_index > subject.tokens.length).to eq(true)
        expect { subject.peak(test_index) }.to raise_error(CompilationEngine::IncorrectTokenIndex)
      end
    end
  end
end
