class JackTokenizer
  
  def initialize(path)
    @lines = IO.readlines(path)
    @temp = nil
  end

  def build_tokens(file_lines_array)
  
  end

  # remove three types of comments '//....', '/* .... */', '/** ..... */'
  def remove_comments(file_lines_array)
    reviewed_array = []

    file_lines_array.each do |line|
      return_line = line

      return_line.include?('//') ? return_line = return_line.gsub(/\/\/.*\r\n/, "\r\n") : nil
      return_line.include?('/*') ? return_line = return_line.gsub(/\/\*.*\*\//, '') : nil
      return_line.include?('/**') ? return_line = return_line.gsub(/\/\*\*.*\*\//, '') : nil
      reviewed_array.append(return_line)
    end
    
    reviewed_array
  end

  def lines
    i = 0 
    @lines.each do |line| 
      result = line.index('')
      print "#{i}_#{result}:  #{line} " 
      i = i + 1
    end
  end
end
