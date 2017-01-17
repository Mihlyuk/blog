# set path to application
app_dir = File.expand_path("../../..", __FILE__)
shared_dir = "#{File.expand_path("../../..", __FILE__)}/shared"
working_directory app_dir

# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Set up socket location
listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64

# Logging
stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

# Set master PID location
pid "#{shared_dir}/pids/unicorn.pid"

after_fork do |server, worker|

  # Override the default logger to use a separate log for each Unicorn worker.
  # https://github.com/rails/rails/blob/3-2-stable/railties/lib/rails/application/bootstrap.rb#L23-L49
  Rails.logger = ActiveRecord::Base.logger = ActionController::Base.logger = begin
    path = Rails.configuration.paths["log"].first
    f = File.open(path.sub(".log", "-#{worker.nr}.log"), "a")
    f.binmode
    f.sync = true
    logger = ActiveSupport::TaggedLogging.new(ActiveSupport::BufferedLogger.new(f))
    logger.level = ActiveSupport::BufferedLogger.const_get(Rails.configuration.log_level.to_s.upcase)

    logger
  end
end