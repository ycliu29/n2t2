require './projects/10/JackAnalyzer/CompilationEngine.rb'
ce = CompilationEngine.new('./projects/10/ExpressionLessSquare/MainT.xml')
ce.compile_class
ce.output.close
