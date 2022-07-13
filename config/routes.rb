Rails.application.routes.draw do
  root "game#start"
  get "/game", to: "game#start"

end
