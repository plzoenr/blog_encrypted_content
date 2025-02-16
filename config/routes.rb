Rails.application.routes.draw do
  root to: 'blogs#index'

  get  '/import', to: 'blogs#import'
  post '/import', to: 'blogs#create'

  get  '/export', to: 'blogs#export'

  get  '/:slug', to: 'blogs#show', as: :show_blog

  resources :blogs, only: [:index, :update], param: :slug
end
