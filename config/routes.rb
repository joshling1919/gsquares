Rails.application.routes.draw do
  resources :students, only: [:index, :destroy]
  get '/' => 'students#index'
  get '/0' => 'students#josh'
  get '/1' => 'students#andrew'
  get '/2' => 'students#eli'
  get '/3' => 'students#laura'
end
