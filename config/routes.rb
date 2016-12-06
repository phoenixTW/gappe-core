Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations", omniauth_callbacks: "omniauth_callbacks" }

  get '/chat_rooms' => "chat_room#index", :format => :json
  post '/chat_rooms' => "chat_room#create", :format => :json
end
