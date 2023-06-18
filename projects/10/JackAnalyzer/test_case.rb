require './projects/10/JackAnalyzer/CompilationEngine.rb'
ce = CompilationEngine.new('./projects/10/ArrayTest/MainT.xml')
ce.compile_class
ce.output.close