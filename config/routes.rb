Rails.application.routes.draw do
  # resources :students, only: [:index]
  get '/students' => 'students#index'
  get '/students/0' => 'students#josh'
  get '/students/1' => 'students#andrew'
  get '/students/2' => 'students#eli'
  get '/students/3' => 'students#laura'
end
