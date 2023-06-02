# frozen_string_literal: true

server '<ip>', port: '<port>', roles: %i[web app db], primary: true
set :branch, 'main'
set :rails_env, :production
set :sidekiq_env, :production
set :stage, :production
