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
      @win_status = 'lose'
      @current_round = 1
    end

    def play
      # initialize board
      puts 'Ready to play?'
      puts "\n\n"
      board = Board.new(@code_options, @code_length)

      # initialize secret code
      board.secret_code = generate_secret_computer_code(@code_options, @code_length)
      @secret_code = board.secret_code
      # loop for each guessing round
      identify_game_parameters
      until game_over?
        puts "\nRound #{@current_round}"
        round = Round.new(@code_options, @code_length)
        round.prompt_code_breaker
        check_answer(round.guess)
        board.save_guess(@current_round, round.guess)
        display_board(board)
        # ##give hint
        increment_round
      end
      # end of game formalities
      end_of_game_formalities
    end

    def identify_game_parameters
      puts "The secrect code is #{@code_length} keys long."
      puts "Each key is an integer from 1 to #{@code_options}."
      puts "You get up to #{@max_guesses} guesses."
      puts "\n"
    end

    def game_over?
      return false unless @game_status == 'finished'

      true
    end

    def increment_round
      @current_round += 1

      return unless @current_round >= @max_guesses

      @game_status = 'finished'
    end

    def check_answer(guess)
      puts "\nguess: \n"
      p guess
      puts "\ncode: \n"
      p @secret_code
      return false unless guess == @secret_code

      @win_status = 'win'
      @game_status = 'finished'
      true
    end

    def generate_secret_computer_code(code_options, code_length)
      secret_code = Array.new(code_length)
      secret_code.each_with_index do |_num, index|
        secret_code[index] = rand(1..code_options)
      end
      puts 'The computer generated a secret code...'
      p secret_code
      secret_code
    end

    def end_of_game_formalities
      puts "\n\nGame over I guess."
      if @win_status == 'win'
        puts 'You Win!!!'
        puts "You found the secret code in round #{@current_round}."
      else
        puts 'looooser'
      end
    end

    def display_board(board)
      board.guesses.each_with_index do |round, index|
        puts "Round: #{board.guesses[index][0]}\tGuess: #{board.guesses[index][1]}\tHint: #{board.guesses[index][2]}"
      end
    end
  end
end
