set :rails_env, 'production'

server '185.143.173.203', user: 'konstantin', roles: %w{app db web}

set :ssh_options, {
    keys: %w(~/.ssh/id_rsa),
    forward_agent: true
}
