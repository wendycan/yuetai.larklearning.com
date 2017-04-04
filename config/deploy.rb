# config valid only for current version of Capistrano
lock "3.8.0"

set :application, "yuetai"
set :repo_url, "git@github.com:wendycan/yuetai.larklearning.com.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# namespace :bower do
#   desc 'Install bower'
#   task :install do
#     on roles(:web) do
#       within release_path do
#         execute :rake, 'bower:install CI=true'
#       end
#     end
#   end
# end

namespace :bower do
  desc 'Install bower'
  task :install do
      sh "cd #{release_path}; bower install"
  end
end

before 'deploy:compile_assets', 'bower:install'
