require 'rspec'
require 'pry'
require 'tempfile'
require_relative 'CompilationEngine.rb'

RSpec.describe CompilationEngine do
  subject { described_class.new(test_file) }

  describe 'methods' do
    let(:test_file) { Tempfile.new }
    let(:file_data) { "<symbol> . </symbol>\r\n<identifier> println </identifier>\r\n<symbol> ( </symbol>\r\n<symbol> ) </symbol>\r\n<symbol> ; </symbol>\r\n<keyword> return </keyword>\r\n</tokens>\r\n" }
    let!(:prepare_test_file) do
      file = File.open("#{test_file.path}", 'w')
      file.write(file_data)
      file.close
    end

    describe '.peak' do
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

    describe '.compile_class_var_dec_or_subroutine' do
      context 'when current token does not belong to either method' do
        it do
          expect(CompilationEngine).not_to receive(:compile_class_var_dec)
          expect(CompilationEngine).not_to receive(:compile_subroutine)
          CompilationEngine.compile_class_var_dec_or_subroutine(subject)
        end
      end

      context 'when current token matches compile_class_var_dec' do
        let!(:compilation_engine) { described_class.new(test_file) }
        let!(:set_up_token) { compilation_engine.tokens[0] = "<keyword> static </keyword>\r\n" }

        it do
          expect(CompilationEngine).to receive(:write_class_v_declaration).once
          CompilationEngine.compile_class_var_dec_or_subroutine(compilation_engine)
        end
      end

      context 'when current token matches compile_subroutine' do
        let!(:set_up_token) { subject.tokens[0] = "<keyword> function </keyword>\r\n" }

        # it do
        #   expect(subject).to receive(:compile_subroutine).once
        #   subject.compile_class_var_dec_or_subroutine
        # end
      end

      context 'when the next two tokens matches compile_subroutine' do
        let!(:set_up_token) { subject.tokens[0] = "<keyword> function </keyword>\r\n" }
        let!(:set_up_token2) { subject.tokens[1] = "<keyword> function </keyword>\r\n" }

        # it do
        #   expect(subject).to receive(:compile_subroutine).twice
        #   subject.compile_class_var_dec_or_subroutine
        # end
      end
    end
  end
end
