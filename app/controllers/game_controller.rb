class GameController < ApplicationController
  skip_before_action :verify_authenticity_token

  def start
    words = %w[programming fun internship ruby rails coding design]
    game = GameSession.new(word_to_guess: words.sample)
    game.save
    render('start')
  end

  def word_guess
    user_guess = params[:guess] # .chomp.downcase
    game = GameSession.last
    @hidden_word = game.word_to_guess.chars.map { '_' }
    @lives = 9
    render('word_guess')
  end
end
