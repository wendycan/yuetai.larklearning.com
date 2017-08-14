application_path = "/home/wendy/sites/yuetai.larklearning.com"
app_root = "#{application_path}"
pidfile "#{app_root}/tmp/pids/puma.pid"
state_path "#{app_root}/tmp/pids/puma.state"
bind "#{app_root}/tmp/sockets/puma.sock"

worker_timeout 60
daemonize true
threads 2, 32
preload_app!
workers 2

# on_worker_boot do
#   ActiveSupport.on_load(:active_record) do
#     ActiveRecord::Base.establish_connection
#   end
# end
