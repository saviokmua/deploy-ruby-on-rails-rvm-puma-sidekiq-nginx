# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.17.2'

set :application,     'application'
set :repo_url,        'git@github.com:saviokmua/deploy-ruby-on-rails-rvm-puma-sidekiq-nginx.git'
set :user,            'deployer'
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :linked_files, %w[config/database.yml .env.production]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads public/system storage]
# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/id_rsa.pub] }
set :log_level,     :debug
set :keep_releases, 5

# Puma options
set :puma_phased_restart, true
set :puma_enable_socket_service, true
set :puma_user, fetch(:user)
set :puma_role, :web
set :puma_service_unit_env_files, []
set :puma_service_unit_env_vars, []
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to false when not using ActiveRecord

# Sidekiq options
set :sidekiq_default_hooks, true
set :sidekiq_roles, fetch(:sidekiq_role, :app)
set :sidekiq_options_per_process, nil
set :sidekiq_user, -> { fetch(:user) }
set :sidekiq_max_mem, nil
set :service_unit_name, "sidekiq-#{fetch(:stage)}.service"
set :sidekiq_service_unit_user, :system
set :rvm_map_bins, fetch(:rvm_map_bins).to_a.concat(%w[sidekiq])
# Bundler integration
set :bundle_bins, fetch(:bundle_bins).to_a.concat(%w[sidekiq])
# Options for single process setup
set :sidekiq_require, nil
set :sidekiq_tag, nil
set :sidekiq_queue, nil
set :sidekiq_config, nil
set :sidekiq_concurrency, nil
set :sidekiq_options, nil

# Monit options
set :sidekiq_monit_conf_dir, '/etc/monit/conf.d'
set :sidekiq_monit_conf_file, "sidekiq-#{fetch(:stage)}.conf"
set :sidekiq_monit_use_sudo, true
set :sidekiq_monit_max_mem, nil
set :monit_bin, '/usr/bin/monit'
set :sidekiq_monit_default_hooks, true
set :sidekiq_monit_group, nil
