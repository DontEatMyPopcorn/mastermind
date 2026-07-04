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
        hint = evaluate_guess(round.guess)
        board.save_guess(@current_round, round.guess, hint)
        display_board(board)
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
      secret_code
    end

    def end_of_game_formalities
      puts "\n\nGame over..."
      sleep 1
      puts 'The secret code was'
      p @secret_code
      puts '...'
      sleep 1
      if @win_status == 'win'
        puts 'You Win!!!'
        puts "You found the secret code in round #{@current_round - 1}."
      else
        puts 'You Lose!'
        puts 'You took too long. Better luck next time.'
      end
    end

    def display_board(board)
      board.guesses.each_with_index do |_round, index|
        puts "Round: #{board.guesses[index][0]}\tGuess: #{board.guesses[index][1]}\t\tHint: #{board.guesses[index][2]}"
      end
    end

    def evaluate_guess(guess)
      # ##compare Guess to the secret code...
      temp_code = @secret_code.dup
      temp_guess = guess.dup
      correct = 0
      close = 0
      temp_guess.each_with_index do |key, index|
        next unless temp_code[index] == key

        correct += 1
        temp_code[index] = nil
        temp_guess[index] = nil
      end
      temp_guess.each_with_index do |key1, index1|
        temp_code.each_with_index do |key2, index2|
          next unless !key1.nil? && (key2 == key1)

          close += 1
          temp_code[index2] = nil
          break
        end
      end
      ###
      hint = "#{correct} correct, #{close} in the wrong position"
    end
  end
end
