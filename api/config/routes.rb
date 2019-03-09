Rails.application.routes.draw do
  resources :counters, only: [:index, :create, :increment] do
    get 'increment', on: :member
    get 'increment_async', on: :member
  end
end
