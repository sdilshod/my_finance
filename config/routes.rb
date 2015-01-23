Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions'
  }

  root 'welcome#index'

  resources :operations, except: :show do
    collection do
      get :fill_subcategory
      get :list_filter
    end
  end

  #TODO change(categories and subcategories) with sub-resources
  resources :categories
  resources :subcategories

end
