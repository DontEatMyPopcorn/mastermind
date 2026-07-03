# frozen_string_literal: true

# The Mastermind module includes everything needed ot play a game of mastermind.
module Mastermind
  # A game is a single round of Mastermind.
  # Initially, of the four game types (computer vs. user, user vs. computer, user vs. user, computer vs. computer),
  #   only the first (computer vs user) is supported.
  class Game
    def initialize(game_type, parameters)
      @game_type = game_type
      @code_options = parameters[0]
      @max_guesses = parameters[1]
      @game_status = 'playing'
    end

    def play
      puts 'We all win!'
      # initilize code
      ### TO DO
      # loop for each guessing round
      until game_over?
        ### TO DO
        puts 'enless loop! Do you want out?'
        input = gets.chomp
        @game_status = 'finished' if input.downcase == 'yes'
      end
      # end of game formalities
      ### TO DO
      puts 'Game over I guess.'
    end

    def game_over?
      return false unless @game_status == 'finished'

      true
    end
  end
end
