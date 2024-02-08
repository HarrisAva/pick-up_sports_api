Rails.application.routes.draw do
 
  # # localhost:3000/users
  # get '/users', to: 'users#index'

  # # localhost:3000/users/1
  # get '/users/:id', to: 'users#show'

  #  # localhost:3000/users/
  # post '/users', to: 'users#create'

  #  # localhost:3000/users/3
  # put '/users/:id', to: 'users#update'

  # # localhost:3000/users/3
  # delete '/users/:id', to: 'users#destroy'

  # routes above are already defined in Rails, so they can be removed and replace by 'resources'
  
  # resources :users

  # #customized routes
  # get '/users/:id/posts', to: "users#posts_index"

  # the above resources and customized routes can be modified as below:
    #no need to keep /users/:id
  resources :users do
    get 'posts', to: "users#posts_index"
  end

  resources :posts

end
