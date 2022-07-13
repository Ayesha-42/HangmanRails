class GameController < ApplicationController

  def initialize
    super
    @lives = 9
    @words = %w[programming fun internship ruby rails coding design]
  
    @word_to_guess = @words.sample
    @hidden_word = @word_to_guess.chars.map { '_' }
  end

end
