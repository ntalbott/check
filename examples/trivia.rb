class Trivia
  def initialize(fact)
    @fact = fact
  end
  attr_reader :fact
end

if __FILE__ == $0
  require 'check'
  trivia = Trivia.new('Rubies are red')
  check('Ruby trivia'){trivia.fact == 'Rubies are red'}
end
