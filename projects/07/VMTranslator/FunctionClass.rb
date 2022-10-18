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
    else command_hash
    end
  end

  def self.writeArithmetic(command)
    case command
    when 'add'
      <<~CODE
      // add
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
      // sub
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
      // neg
      @SP
      A = M-1
      M = -M

      CODE
    when 'eq'
      <<~CODE
      // eq

      CODE
    end

  end

  def self.writePushPop(command_hash)
    if command_hash[:commandType] == 'C_PUSH'
      case command_hash[:segment]
      when 'constant'
        <<~CODE
        // #{command_hash[:arg1]} #{command_hash[:segment]} #{command_hash[:index]}
        @#{command_hash[:index]} // *sp = i
        D = A
        @SP
        A = M
        M = D
        @SP // sp++
        M = M+1
        
        CODE
      end
    end

    # pop to be added
  end
end
