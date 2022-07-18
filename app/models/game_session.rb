class GameSession < ApplicationRecord
  TOTAL_LIVES = 9
  WORDS = %w[programming fun internship ruby rails coding design].freeze

  before_create :set_word

  def lives_remaining
    updated_lives = TOTAL_LIVES
    guesses.chars.each do |letter|
      updated_lives -= 1 if word_to_guess.exclude? letter
    end
    updated_lives
  end

  def hidden_word
    hidden_word = word_to_guess.chars.map { '_' }
    guesses.chars.each do |letter|
      next unless word_to_guess.include? letter

      hidden_word = hidden_word.filter_map.with_index do |hidden_letter, index|
        letter == word_to_guess[index] ? letter : hidden_letter
      end
    end
    hidden_word
  end

  def win?
    hidden_word.join('') == word_to_guess
  end

  def loss?
    lives_remaining < 1
  end

  private

  def set_word
    self.word_to_guess = WORDS.sample
  end
end
