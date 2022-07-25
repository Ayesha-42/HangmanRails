require 'rails_helper'
require 'support/custom_matchers'


RSpec.describe GameSession, type: :model do

  context 'class constants' do
    it 'should have an array list to select from' do
      defined? GameSession::WORDS
    end
  end

  context '.create' do
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
end
