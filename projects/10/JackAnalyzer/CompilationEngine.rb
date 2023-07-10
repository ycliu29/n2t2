require 'pry'

class CompilationEngine
  attr_accessor :tokens, :token_index, :indentation, :output

  OPERATOR = %w[+ - * / & | < > = &lt; &gt; &quot; &amp;]
  UNARYOP = %w[- ~]

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

  def compile_class

    # token
    eat('tokens', nil)
    indent
    output.write("<class>")
    add_linebreak

    # class / className / {
    @indentation += 2
    eat('keyword', 'class')
    indent_and_write_last_token
    eat('identifier', nil)
    indent_and_write_last_token
    eat('symbol', '{')
    indent_and_write_last_token

    while %w(static field constructor function method).include?(peak(0)[:value])
      compile_class_var_dec_or_subroutine_dec
    end

    # } / token
    eat('symbol', '}')
    indent_and_write_last_token

    @indentation -= 2
    eat('tokens', nil)
    indent
    @output.write("</class>")
    add_linebreak
  end

  def compile_class_var_dec_or_subroutine_dec
    current_token = peak(0)[:value]

    case current_token
    when 'static', 'field'
      compile_class_var_dec
    when 'constructor', 'function', 'method'
      compile_subroutine_dec
    end
  end

  def compile_class_var_dec
    indent
    output.write('<classVarDec>')
    add_linebreak
    @indentation += 2

    eat('keyword')
    indent_and_write_last_token

    # int | char | boolean | className
    if peak(0)[:type] == 'keyword'
      eat('keyword')
      indent_and_write_last_token
    else
      eat('identifier')
      indent_and_write_last_token
    end

    eat('identifier')
    indent_and_write_last_token

    while peak(0)[:value] != ';'
      eat('symbol', ',')
      indent_and_write_last_token

      eat('identifier')
      indent_and_write_last_token
    end

    eat('symbol', ';')
    indent_and_write_last_token

    @indentation -= 2
    indent
    output.write('</classVarDec>')
    add_linebreak
  end

  def compile_subroutine_dec
    indent
    output.write("<subroutineDec>")
    add_linebreak
    @indentation += 2

    # constructor | function | method
    eat('keyword')
    indent_and_write_last_token

    # void | type(int, char, boolean, className)
    @token_index += 1
    indent_and_write_last_token

    # subroutine name
    eat('identifier')
    indent_and_write_last_token

    eat('symbol', '(')
    indent_and_write_last_token

    compile_parameter_list

    eat('symbol', ')')
    indent_and_write_last_token

    compile_subroutine_body

    @indentation -= 2
    indent
    output.write('</subroutineDec>')
    add_linebreak
  end

  def compile_subroutine_body
    indent
    output.write('<subroutineBody>')
    add_linebreak

    @indentation +=2

    eat('symbol', '{')
    indent_and_write_last_token

    compile_var_dec

    compile_statements

    eat('symbol', '}')
    indent_and_write_last_token

    @indentation -=2

    indent
    output.write('</subroutineBody>')
    add_linebreak
  end

  def compile_statements
    indent
    output.write("<statements>")
    add_linebreak

    @indentation += 2

    while %w[let if while do return].include?(peak(0)[:value])
      case peak(0)[:value]
      when 'let' then compile_let
      when 'while' then compile_while
      when 'do' then compile_do
      when 'return' then compile_return
      when 'if' then compile_if
      end
    end

    @indentation -= 2

    indent
    output.write('</statements>')
    add_linebreak
  end

  def compile_if
    indent
    output.write('<ifStatement>')
    add_linebreak
    @indentation += 2

    eat('keyword', 'if')
    indent_and_write_last_token

    eat('symbol', '(')
    indent_and_write_last_token

    compile_expression

    eat('symbol', ')')
    indent_and_write_last_token

    eat('symbol', '{')
    indent_and_write_last_token

    compile_statements

    eat('symbol', '}')
    indent_and_write_last_token

    if peak(0)[:value] == 'else'
      eat('keyword', 'else')
      indent_and_write_last_token

      eat('symbol', '{')
      indent_and_write_last_token

      compile_statements

      eat('symbol', '}')
      indent_and_write_last_token
    end

    @indentation -= 2
    indent
    output.write('</ifStatement>')
    add_linebreak
  end

  def compile_return
    indent
    output.write('<returnStatement>')
    add_linebreak
    @indentation += 2

    eat('keyword', 'return')
    indent_and_write_last_token

    if peak(0)[:value] != ';'
      compile_expression
    end

    eat('symbol', ';')
    indent_and_write_last_token

    @indentation -= 2
    indent
    output.write('</returnStatement>')
    add_linebreak
  end

  def compile_do
    indent
    output.write('<doStatement>')
    add_linebreak
    @indentation += 2

    eat('keyword', 'do')
    indent_and_write_last_token

    case peak(1)[:value]
    when '('
      eat('identifier')
      indent_and_write_last_token

      eat('symbol', '(')
      indent_and_write_last_token

      compile_expression_list

      eat('symbol', ')')
      indent_and_write_last_token
    when '.'
      eat('identifier')
      indent_and_write_last_token

      eat('symbol', '.')
      indent_and_write_last_token

      eat('identifier')
      indent_and_write_last_token

      eat('symbol', '(')
      indent_and_write_last_token

      compile_expression_list

      eat('symbol', ')')
      indent_and_write_last_token
    end

    eat('symbol', ';')
    indent_and_write_last_token

    @indentation -= 2
    indent
    output.write('</doStatement>')
    add_linebreak
  end

  def compile_while
    indent
    output.write('<whileStatement>')
    add_linebreak
    @indentation += 2

    eat('keyword', 'while')
    indent_and_write_last_token

    eat('symbol', '(')
    indent_and_write_last_token

    compile_expression

    eat('symbol', ')')
    indent_and_write_last_token

    eat('symbol', '{')
    indent_and_write_last_token

    compile_statements

    eat('symbol', '}')
    indent_and_write_last_token

    @indentation -= 2
    indent
    output.write('</whileStatement>')
    add_linebreak
  end

  def compile_let
    indent
    output.write('<letStatement>')
    add_linebreak
    @indentation += 2

    eat('keyword', 'let')
    indent_and_write_last_token

    eat('identifier')
    indent_and_write_last_token

    if peak(0)[:value] == '['
      eat('symbol', '[')
      indent_and_write_last_token

      compile_expression

      eat('symbol', ']')
      indent_and_write_last_token
    end

    eat('symbol', '=')
    indent_and_write_last_token

    compile_expression

    eat('symbol', ';')
    indent_and_write_last_token

    @indentation -= 2
    indent
    output.write('</letStatement>')
    add_linebreak
  end

  def compile_expression
    indent
    output.write('<expression>')
    add_linebreak
    @indentation += 2

    compile_term

    if OPERATOR.include?(peak(0)[:value])
      # operator
      @token_index += 1
      indent_and_write_last_token

      compile_term
    end

    @indentation -= 2
    indent
    output.write('</expression>')
    add_linebreak
  end

  def compile_term
    indent
    output.write('<term>')
    add_linebreak
    @indentation += 2

    if peak(1)[:value] == '['
      eat('identifier')
      indent_and_write_last_token

      eat('symbol', '[')
      indent_and_write_last_token

      compile_expression

      eat('symbol', ']')
      indent_and_write_last_token

    elsif peak(0)[:value] == '('
      eat('symbol', '(')
      indent_and_write_last_token

      compile_expression

      eat('symbol', ')')
      indent_and_write_last_token

    elsif UNARYOP.include?(peak(0)[:value])
      @token_index += 1
      indent_and_write_last_token

      compile_term

    elsif peak(1)[:value] == '('
      eat('identifier')
      indent_and_write_last_token

      eat('symbol', '(')
      indent_and_write_last_token

      compile_expression_list

      eat('symbol', ')')
      indent_and_write_last_token

    elsif peak(1)[:value] == '.'
      eat('identifier')
      indent_and_write_last_token
      eat('symbol','.')
      indent_and_write_last_token
      eat('identifier')
      indent_and_write_last_token
      eat('symbol', '(')
      indent_and_write_last_token

      compile_expression_list

      eat('symbol', ')')
      indent_and_write_last_token
    else
      if %w[integerConstant stringConstant keywordConstant identifier keyword].include?(peak(0)[:type])
        @token_index += 1
        indent_and_write_last_token
      end
    end

    @indentation -= 2
    indent
    output.write('</term>')
    add_linebreak
  end

  def compile_expression_list
    indent
    output.write('<expressionList>')
    add_linebreak
    @indentation += 2

    if peak(0)[:value] != ')'
      compile_expression

      while peak(0)[:value] == ','
        eat('symbol', ',')
        indent_and_write_last_token

        compile_expression
      end
    end

    @indentation -= 2
    indent
    output.write('</expressionList>')
    add_linebreak
  end

  def compile_var_dec
    # var
    while peak(0)[:value] == 'var'
      indent
      output.write('<varDec>')
      add_linebreak

      @indentation += 2

      eat('keyword', 'var')
      indent_and_write_last_token

      # can be keyword (int, char, boolean) or identifier(className)
      @token_index += 1
      indent_and_write_last_token

      eat('identifier')
      indent_and_write_last_token

      while peak(0)[:value] == ','
        eat('symbol')
        indent_and_write_last_token

        eat('identifier')
        indent_and_write_last_token
      end

      eat('symbol')
      indent_and_write_last_token

      @indentation -= 2

      indent
      output.write('</varDec>')
      add_linebreak
    end
  end

  def compile_parameter_list
    indent
    output.write("<parameterList>")
    add_linebreak

    @indentation += 2

    while peak(0)[:value] != ')'
      eat('keyword')
      indent_and_write_last_token

      eat('identifier')
      indent_and_write_last_token

      if peak(0)[:value] == ','
        eat('symbol', ',')
        indent_and_write_last_token
      end
    end

    @indentation -= 2

    indent
    output.write("</parameterList>")
    add_linebreak
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
