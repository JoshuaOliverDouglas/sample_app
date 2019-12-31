Rails.application.routes.draw do
  get 'static_pagges/home'
  get 'static_pagges/help'
  root 'application#hello'
end
