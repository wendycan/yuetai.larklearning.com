rails_env = ENV['RAILS_ENV'] || 'production'
rails_root = ENV['RAILS_ROOT'] || File.expand_path('../..', __FILE__)

worker_processes rails_env == 'production' ? 8 : 2

working_directory rails_root

user 'wendy','staff'

listen '/tmp/unicorn.yuetai.sock'

timeout 30

pid "#{rails_root}/tmp/pids/unicorn.pid"

stderr_path "#{rails_root}/log/unicorn.stderr.log"
stdout_path "#{rails_root}/log/unicorn.stdout.log"

preload_app true

GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

#if gid && Process.egid != gid
#   Process.initgroups(user, gid)
#  Process::GID.change_privilege(gid)
#end

before_fork do |server, worker|
  old_pid = "#{rails_root}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Send 'QUIT' signal to unicorn error!"
    end
  end
end
