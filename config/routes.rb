Rails.application.routes.draw do
  root 'game_session#start'
  get '/game_session', to: 'gamesession#start'

  get '/game_session/word_guess', to: 'game_session#word_guess'
  post '/word_guess' => 'game_session#word_guess'

  get '/game_session/result', to: 'game_session#result'
end
