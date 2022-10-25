class Parser
  def self.parse(line)
    if comment_or_linebreak?(line) == true # return nil
      command_hash = nil
    else
      command_hash = {:commandType => commandType(line),
                      :arg1        => nil,
                      :segment     => nil,
                      :index       => nil}

      case command_hash[:commandType]
      when 'C_ARITHMETIC' then command_hash[:arg1] = arg1(line)
      when 'C_PUSH' 
        command_hash[:arg1] = arg1(line)
        command_hash[:segment] = arg2(line)[0]
        command_hash[:index] = arg2(line)[1]
      when 'C_POP' 
        command_hash[:arg1] = arg1(line)
        command_hash[:segment] = arg2(line)[0]
        command_hash[:index] = arg2(line)[1]
      end
    end
    command_hash
  end

  def self.comment_or_linebreak?(line)
    if line[0..1] == "//"
      true
    elsif line[0] == "\n"
      true
    elsif line[0..1] == "\r\n"
      true
    else
      false
    end
  end

  def self.commandType(line)
    result = ''

    case line[0..1]
    when 'eq' then result = 'C_ARITHMETIC'
    when 'gt' then result = 'C_ARITHMETIC'
    when 'lt' then result = 'C_ARITHMETIC'
    when 'or' then result = 'C_ARITHMETIC'
    end

    case line[0..2]
    when 'add' then result = 'C_ARITHMETIC'
    when 'sub' then result = 'C_ARITHMETIC'
    when 'neg' then result = 'C_ARITHMETIC'
    when 'and' then result = 'C_ARITHMETIC'
    when 'not' then result = 'C_ARITHMETIC'
    when 'pop' then result = 'C_POP'
    end

    case line[0..3]
    when 'push' then result = 'C_PUSH'
    end

    result == '' ? result = 'UNKNOWN' : nil
    result 
  end

  def self.arg1(line)
    index = line.index(/[\n]|[\s]/)
    line[0..(index-1)]
  end

  def self.arg2(line)
    regex = /[\s]([a-zA-Z]+)[\s]([0-9]+)[\s]|[\n]/
    captured_array = regex.match(line).captures
  end
end

class Writer
  def self.write(command_hash)
    if command_hash == nil
      return nil
    end

    case command_hash[:commandType]
    when 'C_ARITHMETIC' then writeArithmetic(command_hash[:arg1])
    when 'C_PUSH' then writePushPop(command_hash)
    when 'C_POP' then writePushPop(command_hash)
    else command_hash
    end
  end

  def self.writeArithmetic(command)
    case command
    when 'add'
      <<~CODE
      // add (line: #{$line_count})
      @SP // sp--
      M = M-1
      @SP // SP* + (SP-1)*
      A = M
      D = M
      @SP
      A = M-1
      M = M+D

      CODE
    when 'sub'
      <<~CODE
      // sub (line: #{$line_count})
      @SP // sp--
      M = M-1
      @SP // (SP-1)* - SP*
      A = M
      D = M 
      @SP
      A = M-1
      M = M-D

      CODE
    when 'neg'
      <<~CODE
      // neg (line: #{$line_count})
      @SP
      A = M-1
      M = -M

      CODE
    when 'eq'
      <<~CODE
      // eq (line: #{$line_count})
      @SP // sp--
      M = M-1
      @SP // SP* == (SP-1)* ?
      A = M
      D = M
      @SP
      A = M-1
      D = D-M
      @EQ#{$line_count}
      D;JEQ
      @SP // (SP-1)* = 0
      A = M-1
      M = 0
      @END#{$line_count}
      0;JEQ
      (EQ#{$line_count}) // (SP-1)* = -1
      @SP
      A = M-1
      M = -1
      (END#{$line_count})

      CODE
    when 'gt'
      <<~CODE
      // gt (line: #{$line_count})
      @SP // sp--
      M = M-1
      @SP // (SP-1)* > SP* ?  
      A = M
      D = M
      @SP
      A = M-1
      D = M-D
      @GT#{$line_count}
      D;JGT
      @SP // (SP-1)* = 0
      A = M-1
      M = 0
      @END#{$line_count}
      0;JEQ
      (GT#{$line_count}) // (SP-1)* = -1
      @SP
      A = M-1
      M = -1
      (END#{$line_count})

      CODE
    when 'lt'
      <<~CODE
      // lt (line: #{$line_count})
      @SP // sp--
      M = M-1
      @SP // (SP-1)* < SP* ?  
      A = M
      D = M
      @SP
      A = M-1
      D = M-D
      @LT#{$line_count}
      D;JLT
      @SP // (SP-1)* = 0
      A = M-1
      M = 0
      @END#{$line_count}
      0;JEQ
      (LT#{$line_count}) // (SP-1)* = -1
      @SP
      A = M-1
      M = -1
      (END#{$line_count})

      CODE
    when 'and'
      <<~CODE
      // and (line: #{$line_count})
      @SP // sp--
      M = M-1
      A = M // (SP-1)* = SP* and (SP-1)*
      D = M
      @SP
      A = M-1
      M = D&M

      CODE
    when 'or'
      <<~CODE
      // or (line: #{$line_count})
      @SP // sp--
      M = M-1
      A = M // (SP-1)* = SP* or (SP-1)*
      D = M
      @SP
      A = M-1
      M = D|M

      CODE
    when 'not'
      <<~CODE
      // not (line: #{$line_count})
      @SP // (SP-1)* = !(SP-1)*
      A = M-1
      M = !M

      CODE
    end
  end

  def self.writePushPop(command_hash)
    if command_hash[:commandType] == 'C_PUSH'
      case command_hash[:segment]
      when 'constant'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
        @#{command_hash[:index]} // *sp = i
        D = A
        @SP
        A = M
        M = D
        @SP // sp++
        M = M+1

        CODE
      when 'local'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
        @#{command_hash[:index]} // target = LCL+index
        D = A
        @LCL
        D = D+M
        @LOCAL#{$line_count}
        M = D
        @LOCAL#{$line_count} // sp* = target*
        A = M
        D = M
        @SP
        A = M
        M = D
        @SP // sp++
        M = M+1

        CODE
      when 'argument'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
        @#{command_hash[:index]} // target = ARG+index
        D = A
        @ARG
        D = D+M
        @ARG#{$line_count}
        M = D
        @ARG#{$line_count} // sp* = target*
        A = M
        D = M
        @SP
        A = M
        M = D
        @SP // sp++
        M = M+1

        CODE
      when 'this'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
        @#{command_hash[:index]} // target = THIS+index
        D = A
        @THIS
        D = D+M
        @THIS#{$line_count}
        M = D
        @THIS#{$line_count} // sp* = target*
        A = M
        D = M
        @SP
        A = M
        M = D
        @SP // sp++
        M = M+1

        CODE
      when 'that'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
        @#{command_hash[:index]} // target = THAT+index
        D = A
        @THAT
        D = D+M
        @THAT#{$line_count}
        M = D
        @THAT#{$line_count} // sp* = target*
        A = M
        D = M
        @SP
        A = M
        M = D
        @SP // sp++
        M = M+1

        CODE
      when 'temp'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
        @#{command_hash[:index]} // target = 5+index
        D = A
        @5
        D = D+A
        @TEMP#{$line_count}
        M = D
        @TEMP#{$line_count} // sp* = target*
        A = M
        D = M
        @SP
        A = M
        M = D
        @SP // sp++
        M = M+1

        CODE
      when 'pointer'
        case command_hash[:index]
        when '0' 
          <<~CODE
          // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
          @THIS // *SP = THIS, SP++
          D = M
          @SP
          A = M
          M = D
          @SP
          M = M+1

          CODE
        when '1' 
          <<~CODE
          // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
          @THAT // *SP = THAT, SP++
          D = M
          @SP
          A = M
          M = D
          @SP
          M = M+1

          CODE
        end
      when 'static'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
        @#{$file_name}.#{command_hash[:index]} // SP* = @#{$file_name}.#{command_hash[:index]}, SP++
        D = M
        @SP
        A = M
        M = D
        @SP
        M = M+1

        CODE
      end
    elsif command_hash[:commandType] == 'C_POP'
      case command_hash[:segment]
      when 'local'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
        @#{command_hash[:index]} // target = LCL+index
        D = A
        @LCL
        D = D+M
        @LOCAL#{$line_count}
        M = D
        @SP // sp--
        M = M-1
        A = M // target* = sp*
        D = M 
        @LOCAL#{$line_count}
        A = M
        M = D

        CODE
      when 'argument'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
        @#{command_hash[:index]} // target = ARG+index
        D = A
        @ARG
        D = D+M
        @ARG#{$line_count}
        M = D
        @SP // sp--
        M = M-1
        A = M // target* = sp*
        D = M 
        @ARG#{$line_count}
        A = M
        M = D

        CODE
      when 'this'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
        @#{command_hash[:index]} // target = THIS+index
        D = A
        @THIS
        D = D+M
        @THIS#{$line_count}
        M = D
        @SP // sp--
        M = M-1
        A = M // target* = sp*
        D = M 
        @THIS#{$line_count}
        A = M
        M = D

        CODE
      when 'that'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
        @#{command_hash[:index]} // target = THAT+index
        D = A
        @THAT
        D = D+M
        @THAT#{$line_count}
        M = D
        @SP // sp--
        M = M-1
        A = M // target* = sp*
        D = M 
        @THAT#{$line_count}
        A = M
        M = D

        CODE
      when 'temp'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
        @#{command_hash[:index]} // target = 5+index
        D = A
        @5
        D = D+A
        @TEMP#{$line_count}
        M = D
        @SP // sp--
        M = M-1
        A = M // target* = sp*
        D = M 
        @TEMP#{$line_count}
        A = M
        M = D

        CODE
      when 'pointer'
        case command_hash[:index]
        when '0' 
          <<~CODE
          // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
          @SP // SP--, THIS = SP*
          M = M-1
          A = M
          D = M
          @THIS
          M = D

          CODE
        when '1'
          <<~CODE
          // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
          @SP // SP--, THAT = SP*
          M = M-1
          A = M
          D = M
          @THAT
          M = D

          CODE
        end
      when 'static'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
        @SP // sp--, @#{$file_name}.#{command_hash[:index]} = SP*
        M = M-1
        A = M
        D = M
        @#{$file_name}.#{command_hash[:index]}
        M = D
        
        CODE
      end
    end
  end
end
