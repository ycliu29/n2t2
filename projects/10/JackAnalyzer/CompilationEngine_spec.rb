require 'rspec'
require 'pry'
require 'tempfile'
require_relative 'CompilationEngine.rb'

RSpec.describe CompilationEngine do
  subject { described_class.new(test_file) }

  describe '.current_token' do
    let(:test_file) { Tempfile.new }
    let(:file_data) { "<symbol> . </symbol>\r\n<identifier> println </identifier>\r\n<symbol> ( </symbol>\r\n<symbol> ) </symbol>\r\n<symbol> ; </symbol>\r\n<keyword> return </keyword>\r\n</tokens>\r\n" }
    let!(:prepare_test_file) { File.open("#{test_file.path}", 'w').write(file_data) }

    it do
      binding.pry
    end

  end
end
