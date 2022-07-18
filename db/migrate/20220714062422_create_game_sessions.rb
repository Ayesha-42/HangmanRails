class CreateGameSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :game_sessions do |t|
      t.string :word_to_guess
      t.string :guesses

      t.timestamps
    end
  end
end
