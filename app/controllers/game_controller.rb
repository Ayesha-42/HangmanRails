class GameController < ApplicationController

  def initialize
    super
    @lives = 9
    @words = %w[programming fun internship ruby rails coding design]
  
    @word_to_guess = @words.sample
    @hidden_word = @word_to_guess.chars.map { '_' }
  end

  def word_guess
    @user_guess = params[:guess] #.chomp.downcase
  
    if @word_to_guess.include? @user_guess
      @hidden_word = @hidden_word.filter_map.with_index do |letter, index|
        @user_guess == @word_to_guess[index] ? @user_guess : letter
      end
    else
      @lives -= 1
    end
    if @hidden_word.join('') == @word_to_guess
      @message = "You won the game!"
      render('result')
    end
    if @lives<1
      @message = "Unfortunately, you've run out of chances to guess, better luck next time!"
      render('result')
    end

    render('v2')
  end


end
