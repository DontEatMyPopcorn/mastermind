# frozen_string_literal: true

# The Mastermind module includes everything needed to play a game of mastermind.
module Mastermind
  # A round includes a code breakers guess.
  class Round
    attr_reader :guess

    def initialize(code_options, code_length)
      @code_options = code_options
      @valid_options = Array.new(code_options)
      @valid_options.each_with_index do |_option, index|
        @valid_options[index] = index + 1
      end
      @code_length = code_length
      @guess = Array.new(code_length)
    end

    def prompt_code_breaker
      print '['
      @guess.each_with_index do |_key, index1|
        @guess[index1] = get_valid_input
        break if index1 >= @code_length - 1

        print "\n["
        @guess.each_with_index do |show, index2|
          print show
          break if index1 >= @code_length

          print ', '
          break if index2 >= index1
        end
      end
      puts "\nGuess:"
      p @guess
      sleep 2
    end

    def get_valid_input
      loop do
        user_input = IO.console.getch.to_i

        break user_input if valid_input?(user_input)

        puts "\n\tInvalid input, try an integer from 1 to #{@code_options}."
      end
    end

    def valid_input?(input)
      @valid_options.include?(input)
    end
  end
end
