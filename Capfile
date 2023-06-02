# frozen_string_literal: true

# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined

require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/rvm'
require 'capistrano/puma'
require 'capistrano/sidekiq/systemd'
require 'capistrano/sidekiq/monit' #to require monit tasks

install_plugin Capistrano::Puma  # Default puma tasks
install_plugin Capistrano::Puma::Systemd
install_plugin Capistrano::Puma::Nginx

require 'capistrano/linked_files'
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
