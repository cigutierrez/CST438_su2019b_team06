Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/items' => 'items#create'
  get '/items' => 'items#get'
  put '/items' => 'items#updateItem'
  put '/items/order' => 'items#updateOrder'
  
  post '/customers' => 'customers#create'
  get '/customers' => 'customers#index'
  put '/customers/order' => 'customers#processOrder'
  
  post '/orders' => 'orders#create'
  get '/orders/:id' => 'orders#show'
  get '/orders' => 'orders#search'
  
  post '/orders' => 'orders#create'
  get  '/orders/:id' => 'orders#show'
  get  '/orders' => 'orders#search'
end
