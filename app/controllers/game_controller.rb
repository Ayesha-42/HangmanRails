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

    @lives = game.lives
    if game.win?
      redirect_to(:action => 'result', :message => "Yay! you won the game :)", :word => game.word_to_guess)
      return
    end

    if @lives < 1
      redirect_to(:action => 'result', :message => "Sorry, you've run out of lives :(", :word => game.word_to_guess)
      return
    end

    render('word_guess')
  end

  def result
    @word_to_guess = params[:word]
    @message = params[:message]
    render('result')
  end

end
