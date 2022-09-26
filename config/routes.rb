Rails.application.routes.draw do
  
  resources :doctors, only: [:show]
  resources :patients, only: [:index]
  resources :patient_doctors, only: [:destroy]
  
end
