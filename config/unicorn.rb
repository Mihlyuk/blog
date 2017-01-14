app_dir = '/var/www/blog'
working_directory "#{app_dir}"

pid "#{app_dir}/tmp/pids/unicorn.pid"

worker_processes 2
preload_app true
timeout 30

listen "#{app_dir}/sockets/unicorn.sock", :backlog => 64

# Logging
stderr_path "#{app_dir}/log/unicorn.stderr.log"
stdout_path "#{app_dir}/log/unicorn.stdout.log"

