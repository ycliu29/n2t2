class JackTokenizer
  
  def initialize(path)
    @lines = IO.readlines(path)
  end

  def lines
    i = 0 
    @lines.each do |line| 
      print "#{i}:  #{line}" 
      i = i + 1
    end
  end
end
