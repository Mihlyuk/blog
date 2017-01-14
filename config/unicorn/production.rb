working_directory '/var/www/blog'

# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Set up socket location
listen '/var/www/blog/shared/sockets/unicorn.sock', :backlog => 64

# Logging
stderr_path '/var/www/blog/log/unicorn.stderr.log'
stdout_path '/var/www/blog/log/unicorn.stdout.log'

# Set master PID location
pid '/var/www/blog/pids/unicorn.pid'
