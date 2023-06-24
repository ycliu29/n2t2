require 'pry'

class CompilationEngine
  attr_accessor :tokens, :token_index, :indentation, :output

  class IncorrectPeakIndex < StandardError; end
  class IncorrectTokenIndex < StandardError; end
  class OutOfRangeLastToken < StandardError; end
  class UnexpectedToken < StandardError; end

  def initialize(token_file_path)
    @tokens = IO.readlines(token_file_path)
    @token_index = 0
    @indentation = 0
    @output = File.open("#{File.dirname(token_file_path)}/#{File.basename(token_file_path, ".*")[0..-2]}_tt.xml", 'w')
  end

  # TODO: 用 while loop 處理 0~n 個可能，改為 instance method（較單純）
  def self.compile_class(compilation_engine)
    ce = compilation_engine

    # token
    ce.eat('tokens', nil)
    ce.indent
    ce.output.write("<class>")
    ce.add_linebreak

    # class / className / {
    ce.indentation += 2
    ce.eat('keyword', 'class')
    ce.indent_and_write_last_token
    ce.eat('identifier', nil)
    ce.indent_and_write_last_token
    ce.eat('symbol', '{')
    ce.indent_and_write_last_token

    compile_class_var_dec_or_subroutine(ce)

    # # } / token
    # eat('symbol', '}')
    # indent_and_write_last_token

    # eat('tokens', nil)
    # @indentation -= 2
    # indent
    # @output.write("</class>")
  end

  def self.compile_class_var_dec_or_subroutine(compilation_engine)
    current_token = compilation_engine.peak(0)[:value]
    puts current_token

    # case current_token
    # when 'static', 'field' then compile_classvar_declaration(compilation_engine)
    #   # compile_class_var_dec_or_subroutine(compilation_engine)
    # when 'constructor', 'function', 'method'
    #   compile_subroutine(compilation_engine)
    #   compile_class_var_dec_or_subroutine(compilation_engine)
    # end
    if %w(static field).include?(current_token)
      binding.pry
      write_class_v_declaration(compilation_engine)
      # compile_class_var_dec_or_subroutine(compilation_engine)
    end
  end

  # def self.compile_class_v_declaration(compilation_engine)
  #   puts "compilation_engine_id: #{compilation_engine.object_id}"
  #   puts "compilation_enginer_token_index_id #{compilation_engine.token_index.object_id}"
  #   compilation_engine.token_index += 1
  # end

  def self.compile_subroutine(compilation_engine)
    compilation_engine.token_index += 1
  end

  def peak(peak_index)
    target_index = @token_index + peak_index
    raise IncorrectPeakIndex if peak_index < 0
    raise IncorrectTokenIndex if target_index > (@tokens.size - 1)

    match_data = /<\/?([A-Za-z]+)>(?: (.+) <\/[A-Za-z]+>)?/.match(@tokens[target_index]).captures
    { type: match_data[0], value: match_data[1] }
  end

  def eat(type, value = nil)
    current_token = peak(0)

    raise UnexpectedToken if type != current_token[:type]
    value.nil? ? nil : ( raise UnexpectedToken if value != current_token[:value] )

    @token_index += 1

    current_token
  end

  def indent_and_write_last_token
    indent
    write_last_token
  end

  def add_linebreak
    @output.write("\r\n")
  end

  def write_last_token
    raise OutOfRangeLastToken if @token_index == 0
    @output.write("#{@tokens[@token_index-1]}")
  end

  def indent
    @output.write("#{" " * @indentation}")
  end
end
