require 'rails_helper'
require 'support/custom_matchers'

RSpec.describe 'GameSession model class constants' do
  it 'should have an array list to select from' do
    defined? GameSession::WORDS
  end
end

RSpec.describe 'GameSession.create' do
  subject { GameSession.create }
  it 'word_to_guess should be assigned' do
    expect(subject.word_to_guess).to_not eq(nil)
  end
  it 'should select word_to_guess from the words array' do
    expect(subject.word_to_guess).to be_included_in(GameSession::WORDS)
  end
  it 'should not have any user guesses to check' do
    expect(subject.guesses).to eq(nil)
  end
end

RSpec.describe 'GameSession methods' do
  let(:test_record) { GameSession.new(word_to_guess: 'test') }

  context '#lives_remaining' do
    it 'correct initial lives_remaining' do
      test_record.guesses = ''
      expect(test_record.lives_remaining).to eq(9)
    end
    it 'correctly decuting lives with incorrect guess' do
      test_record.guesses = 'a'
      expect(test_record.lives_remaining).to eq(8)
    end
    it 'correctly decuting lives with incorrect guesses' do
      test_record.guesses = 'aa'
      expect(test_record.lives_remaining).to eq(7)
    end
    it 'correctly dattributing lives' do
      test_record.guesses = 'aat'
      expect(test_record.lives_remaining).to eq(7)
    end
  end

  context '#hidden_word' do
    it 'initial value when no letter has been guessed' do
      test_record.guesses = ''
      expect(test_record.hidden_word.join('')).to eq('____')
    end
    it 'when all are incorrect guesses' do
      test_record.guesses = 'aa'
      expect(test_record.hidden_word.join('')).to eq('____')
    end
    it 'revealing the letter when guessed correctly' do
      test_record.guesses = 't'
      expect(test_record.hidden_word.join('')).to eq('t__t')
    end
    it 'should only reveal the correctly guessed letter from all the guesses' do
      test_record.guesses = 'ta'
      expect(test_record.hidden_word.join('')).to eq('t__t')
    end
    it 'should check and reveal different correct guesses in their respective positions in the word' do
      test_record.guesses = 'tae'
      expect(test_record.hidden_word.join('')).to eq('te_t')
      test_record.guesses = 'tst'
      expect(test_record.hidden_word.join('')).to eq('t_st')
    end
  end
end
