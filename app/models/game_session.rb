class GameSession < ApplicationRecord
  LIVES = 5

  def lives
    updated_lives = LIVES
    guesses.chars.each do |letter|
      if word_to_guess.exclude? letter
        updated_lives -= 1
      end
    end
    updated_lives
  end

  def get_hidden_word
    hidden_word = word_to_guess.chars.map { '_' }
    guesses.chars.each do |letter|
      if word_to_guess.include? letter
        hidden_word = hidden_word.filter_map.with_index do |hidden_letter, index|
          letter == word_to_guess[index] ? letter : hidden_letter
        end
      end
    end
    hidden_word
  end

  def win?
    get_hidden_word.join('') == word_to_guess
  end

end
