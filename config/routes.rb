Rails.application.routes.draw do
  get 'csp/:action', controller: :csp
  post 'csp/:action', controller: :csp
  root 'csp#index'
end
