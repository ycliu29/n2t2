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
      when 'C_LABEL'
        command_hash[:arg1] = arg1(line)
        command_hash[:segment] = get_mid_section(line)
      when 'C_GOTO'
        command_hash[:arg1] = arg1(line)
        command_hash[:segment] = get_mid_section(line)
      when 'C_IF'
        command_hash[:arg1] = arg1(line)
        command_hash[:segment] = get_mid_section(line)
      when 'C_FUNCTION'
        command_hash[:arg1] = arg1(line)
        command_hash[:segment] = arg2(line)[0]
        command_hash[:index] = arg2(line)[1]
      when 'C_RETURN' then command_hash[:arg1] = arg1(line)
      when 'C_CALL' then 
        command_hash[:arg1] = arg1(line)
        command_hash[:segment] = arg2(line)[0]
        command_hash[:index] = arg2(line)[1]
      end
    end
    command_hash
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
    when 'goto' then result = 'C_GOTO'
    when 'call' then result = 'C_CALL'
    end
    
    case line[0..4]
    when 'label' then result = 'C_LABEL'
    end

    case line[0..5]
    when 'return' then result = 'C_RETURN'
    end

    case line[0..6]
    when 'if-goto' then result = 'C_IF'
    end

    case line[0..7]
    when 'function' then result = 'C_FUNCTION'
    end

    result == '' ? result = 'UNKNOWN' : nil
    result 
  end

  def self.arg1(line)
    index = line.index(/[\n]|[\s]/)
    line[0..(index-1)]
  end

  def self.arg2(line)
    regex = /[\s]([^\s]+)[\s]([0-9]+)[\s]|[\n]/
    captured_array = regex.match(line).captures
  end

  def self.get_mid_section(line)
    regex = /[a-zA-Z]+[\s]([^\s]+)/
    mid_section = regex.match(line).captures.first
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
    when 'C_LABEL' then writeLabel(command_hash)
    when 'C_IF' then writeIf(command_hash)
    when 'C_GOTO' then writeGoto(command_hash)
    when 'C_FUNCTION' then writeFunction(command_hash)
    when 'C_RETURN' then writeReturn(command_hash)
    when 'C_CALL' then writeCall(command_hash)
    else command_hash
    end
  end

  def self.writeInit
    <<~CODE
    // writeInit | SP = 256
    @256
    D = A
    @SP
    M = D

    // Call Sys.init 0

    @RetAddr0 // push returnAddress(SP ++)
    D = A
    @SP 
    A = M
    M = D
    @SP
    M = M + 1

    @LCL // push LCL
    D = M 
    @SP
    A = M
    M = D
    @SP
    M = M + 1

    @ARG // push ARG
    D = M 
    @SP
    A = M
    M = D
    @SP
    M = M + 1

    @THIS // push THIS
    D = M 
    @SP
    A = M
    M = D
    @SP
    M = M + 1

    @THAT // push THAT
    D = M 
    @SP
    A = M
    M = D
    @SP
    M = M + 1

    @5 // ARG = SP - 5 - nArgs
    D = A
    @SP 
    D = M - D  // D = SP - 5
    @ARG13
    M = D
    @0 // - nArgs
    D = A
    @ARG13
    M = M - D
    D = M
    @ARG
    M = D 

    @SP // LCL = SP
    D = M 
    @LCL
    M = D

    @Sys.init // goto functionName
    0 ; JMP

    (RetAddr0) // (returnAddress)

    CODE
  end

  def self.writeCall(command_hash)
    <<~CODE
    // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})

    @RetAddr#{$line_count} // push returnAddress(SP ++)
    D = A
    @SP 
    A = M
    M = D
    @SP
    M = M + 1

    @LCL // push LCL
    D = M 
    @SP
    A = M
    M = D
    @SP
    M = M + 1

    @ARG // push ARG
    D = M 
    @SP
    A = M
    M = D
    @SP
    M = M + 1

    @THIS // push THIS
    D = M 
    @SP
    A = M
    M = D
    @SP
    M = M + 1

    @THAT // push THAT
    D = M 
    @SP
    A = M
    M = D
    @SP
    M = M + 1

    @5 // ARG = SP - 5 - nArgs
    D = A
    @SP 
    D = M - D  // D = SP - 5
    @ARG#{$line_count}
    M = D
    @#{command_hash[:index]} // - nArgs
    D = A
    @ARG#{$line_count}
    M = M - D
    D = M
    @ARG
    M = D 

    @SP // LCL = SP
    D = M 
    @LCL
    M = D

    @#{command_hash[:segment]} // goto functionName
    0 ; JMP

    (RetAddr#{$line_count}) // (returnAddress)

    CODE
  end

  def self.writeReturn(command_hash)
    <<~CODE
    // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
    @LCL // endFrame = LCL
    D = M
    @EndFrame#{$line_count}
    M = D

    @5 // retAddr = *(endFrame - 5)
    D = A
    @EndFrame#{$line_count}
    D = M - D
    A = D
    D = M
    @RetAddr#{$line_count}
    M = D

    @SP // *ARG = pop()
    M = M - 1
    A = M
    D = M
    @ARG
    A = M
    M = D

    @ARG // SP = ARG + 1
    D = M + 1
    @SP
    M = D

    @EndFrame#{$line_count}  // THAT = *(endFrame -1 )
    D = M - 1
    A = D
    D = M
    @THAT
    M = D

    @2  // THIS = *(endFrame -2 )
    D = A
    @EndFrame#{$line_count}
    D = M - D
    A = D
    D = M
    @THIS
    M = D

    @3 // ARG = *(endFrame -3 )
    D = A
    @EndFrame#{$line_count}  
    D = M - D
    A = D
    D = M
    @ARG
    M = D

    @4 // LCL = *(endFrame -4 )
    D = A
    @EndFrame#{$line_count}  
    D = M - D
    A = D
    D = M
    @LCL
    M = D

    @RetAddr#{$line_count}
    A = M
    0;JMP

    CODE

  end

  def self.writeFunction(command_hash)
    <<~CODE
    // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]} (line: #{$line_count})
    (#{command_hash[:segment]}) // create function label

    @#{command_hash[:index]} // save index to a variable
    D = A
    @FUNC#{$line_count}
    M = D

    (START#{command_hash[:segment]})
    @FUNC#{$line_count} // leave loop if variable is 0
    D = M
    @EXIT#{command_hash[:segment]}
    D;JEQ

    @SP // sp* = 0, sp ++
    A = M
    M = 0
    @SP 
    M = M + 1
    @FUNC#{$line_count}
    M = M - 1

    @START#{command_hash[:segment]}
    0;JMP

    (EXIT#{command_hash[:segment]})

    CODE
  end

  def self.writeGoto(command_hash)
    <<~CODE
    // #{command_hash[:arg1]} #{command_hash[:segment]} (line: #{$line_count})
    @#{command_hash[:segment]} 
    0;JEQ

    CODE
  end

  def self.writeLabel(command_hash)
    <<~CODE
    // #{command_hash[:arg1]} #{command_hash[:segment]} (line: #{$line_count})
    (#{command_hash[:segment]}) // create a label

    CODE
  end

  def self.writeIf(command_hash)
    <<~CODE
    // #{command_hash[:arg1]} #{command_hash[:segment]} (line: #{$line_count})
    @SP // sp --
    M = M-1
    A = M // D = sp*
    D = M
    @#{command_hash[:segment]}
    D;JNE

    CODE
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
