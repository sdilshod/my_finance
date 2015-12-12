Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions'
  }

  root 'welcome#index'

  match '/db_tables_information' => 'welcome#db_tables_information', via: :get, as: :db_tables_info

  resources :operations, except: :show do
    collection do
      get :fill_subcategory
      get :list_filter
    end
  end

  #TODO change(categories and subcategories) with sub-resources
  resources :categories
  resources :subcategories

  match '/*path' => 'welcome#not_found', via: :get

end
