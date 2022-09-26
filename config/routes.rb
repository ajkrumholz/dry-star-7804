Rails.application.routes.draw do
  
  resources :doctors, only: [:show]
  resources :patient_doctors, only: [:destroy]
  
end
