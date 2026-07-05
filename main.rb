# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/round'

require 'io/console'

# Game Types Enumerated
GAME_TYPE_1 = 1 # computer (code maker) vs. user (code breaker)
GAME_TYPE_2 = 2 # user (code maker) vs. computer (code breaker)
GAME_TYPE_3 = 3 # user (code maker) vs. user (code breaker)
GAME_TYPE_4 = 4 # computer (code maker) vs. computer (code breaker)
GAME_PARAMETERS = [4, 4, 10].freeze # code options, code length, guesses

puts "Welcome! Let's play a game of Mastermind."
Mastermind::Game.new(GAME_TYPE_1, GAME_PARAMETERS).play
