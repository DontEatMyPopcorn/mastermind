# frozen_string_literal: true

# The Mastermind module includes everything needed to play a game of mastermind.
module Mastermind
  # The board class contains the state of the board and player actions to adjust the board state.
  class Board
    attr_accessor :secret_code, :guesses

    def initialize(code_options, code_length)
      @code_options = code_options
      @code_length = code_length
      @secret_code = Array.new(code_length)
      @guesses = []
    end

    def save_guess(round, guess)
      @guesses.push([round, guess, nil])
    end
  end
end
