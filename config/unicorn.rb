worker_processes ENV['WORKER_PROCESSES'].to_i
listen ENV['LISTEN_ON']

timeout 30

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

check_client_connection false

after_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end
