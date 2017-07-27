Rails.application.routes.draw do
  resources :students, only: [:index, :destroy]
  root to: 'students#josh'
  get '/0' => 'students#josh'
  get '/1' => 'students#andrew'
  get '/2' => 'students#eli'
  get '/3' => 'students#laura'
end
