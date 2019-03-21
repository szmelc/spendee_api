Rails.application.routes.draw do
  mount API::Core, at: '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
