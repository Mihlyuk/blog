set :application, 'blog'
set :repo_url, 'https://github.com/Mihlyuk/blog.git'

set :rvm_type, :user
set :rvm_ruby_version, '2.3.3'
set :migration_servers, -> { primary(fetch(:migration_role)) }

set :assets_roles, [:web, :app]

set :normalize_asset_timestamps, %w{public/images public/javascripts public/stylesheets}

set :keep_assets, 2

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
    task :restart do
        invoke 'unicorn:start'
    end
end