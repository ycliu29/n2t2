class Parser
  attr_accessor
  def initialize
  end

  def parse(line)
    if comment_or_linebreak?(line) == true
    else
      commandType(line)
    end
  end

  def comment_or_linebreak?(line)
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

  def commandType(line)
    result = ''
    case line[0..2]
    when 'add' then result = 'C_ARITHMETIC'
    when 'sub' then result = 'C_ARITHMETIC'
    when 'neg' then result = 'C_ARITHMETIC'
    when 'and' then result = 'C_ARITHMETIC'
    when 'not' then result = 'C_ARITHMETIC'
    end

    case line[0..1]
    when 'eq' then result = 'C_ARITHMETIC'
    when 'gt' then result = 'C_ARITHMETIC'
    when 'lt' then reslut = 'C_ARITHMETIC'
    when 'or' then result = 'C_ARITHMETIC'
    end

    result == '' ? result = 'UNKNOWN' : nil
    result 
  end
end

class Writer
end
