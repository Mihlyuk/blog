set :application, 'Blog'

set :migration_role, :db

set :migration_servers, -> { primary(fetch(:migration_role)) }

set :conditionally_migrate, true

set :assets_roles, [:web, :app]

set :assets_prefix, 'prepackaged-assets'

set :normalize_asset_timestamps, %w{public/images public/javascripts public/stylesheets}

set :keep_assets, 2
