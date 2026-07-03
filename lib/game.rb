# frozen_string_literal: true

# The Mastermind module includes everything needed to play a game of mastermind.
module Mastermind
  # A game is a single round of Mastermind.
  # Initially, of the four game types (computer vs. user, user vs. computer, user vs. user, computer vs. computer),
  #   only the first (computer vs user) is supported.
  class Game
    def initialize(game_type, parameters)
      @game_type = game_type
      @code_options = parameters[0]
      @code_length = parameters[1]
      @max_guesses = parameters[2]
      @game_status = 'playing'
    end

    def play
      # initialize board
      board = Board.new(@code_options, @code_length)
      puts 'Ready to play?'
      puts "\n\n"
      # initialize secret code
      board.secret_code = generate_secret_computer_code(@code_options, @code_length)

      # loop for each guessing round
      puts 'The secrect code is ' + @code_length.to_s + ' keys long.'
      puts 'Each key is an integer from 1 to ' + @code_options.to_s + '.'
      puts 'You get up to ' + @max_guesses.to_s + ' guesses.'
      puts "\n"
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

    def generate_secret_computer_code(code_options, code_length)
      secret_code = Array.new(code_length)
      secret_code.each_with_index do |_num, index|
        secret_code[index] = rand(1..code_options)
      end
      puts 'The computer generated a secret code...'
      secret_code
    end
  end
end
