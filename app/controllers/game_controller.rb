class GameController < ApplicationController
  skip_before_action :verify_authenticity_token

  def start
    words = %w[programming fun internship ruby rails coding design]
    game = GameSession.new(word_to_guess: words.sample, guesses: '')
    game.save
    render('start')
  end

  def word_guess
    user_guess = params[:guess] # .chomp.downcase
    game = GameSession.last
    guesses = game.guesses
    game.update(guesses: guesses + user_guess)
    @hidden_word = game.get_hidden_word
    @lives = 9
    render('word_guess')
  end
end
