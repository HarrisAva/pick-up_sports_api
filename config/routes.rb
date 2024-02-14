Rails.application.routes.draw do
  # get 'profiles/show' # replace with scope :profile
  get 'sessions/create'
 
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

  scope '/' do  
    # scope adds onto the path itself to these request (grouping all of root paths)
    post 'login', to: 'sessions#create' 
    # route to sessions control and execute create action

  end
  resources :events
  scope :profiles do
    get ':username', to: "profiles#show"
  end
  resources :posts
  resources :users do
    get 'posts', to: "users#posts_index"
  end

  

end
