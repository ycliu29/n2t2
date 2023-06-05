require 'rspec'
require 'pry'
require_relative 'CompilationEngine.rb'

RSpec.describe CompilationEngine do
  subject { described_class.new(test_file) }


end
