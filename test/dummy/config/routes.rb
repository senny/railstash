Rails.application.routes.draw do
  resources :articles


  get 'custom_with_context' => 'custom_log#with_context'
  get 'custom_without_context' => 'custom_log#without_context'
end
