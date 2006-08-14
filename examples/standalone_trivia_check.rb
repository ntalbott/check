require 'check'
require 'trivia'

trivia = Trivia.new('Rubies are red')
check('Ruby trivia'){trivia.fact == 'Rubies are red'}
