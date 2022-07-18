class GameSessionController < ApplicationController
  skip_before_action :verify_authenticity_token

  def start
    GameSession.create
    render('start')
  end

  def word_guess
    user_guess = params[:guess] # .chomp.downcase
    game = GameSession.last
    guesses = game.guesses || ''
    game.update(guesses: guesses + user_guess)
    @hidden_word = game.hidden_word

    @lives_remaining = game.lives_remaining
    if game.win?
      redirect_to(action: 'result', message: 'Yay! you won the game :)', word: game.word_to_guess)
    elsif game.loss?
      redirect_to(action: 'result', message: "Sorry, you've run out of lives :(", word: game.word_to_guess)
    else
      render('word_guess')
    end
  end

  def result
    @word_to_guess = params[:word]
    @message = params[:message]
    render('result')
  end
end
