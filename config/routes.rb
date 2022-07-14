Rails.application.routes.draw do
  root 'game#start'
  get '/game', to: 'game#start'

  get '/game/word_guess', to: 'game#word_guess'
  post '/word_guess' => 'game#word_guess'

  get '/game/result', to: 'game#result'
end
