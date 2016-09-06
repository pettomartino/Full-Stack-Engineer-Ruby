if defined?(Rails::Server) && Rails.env.development?
  pid = fork { exec('cd frontend && npm run build') }

  at_exit do
    Process.kill('INT', pid)
    Process.waitpid(pid)
  end
end