require 'check'

def run_isolated(check_all_messages=false)
  read, write = IO.pipe
  fork do
    read.close
    STDERR.reopen(write)
    $check_ok = true
    $check_all_messages = check_all_messages

    yield
  end
  write.close
  Process.wait
  read.read
end

output = run_isolated(true) do
  check("true"){true}
  check("false"){false}
end

check("Successful check") do
  /ok - true/ =~ output
end

check("Failed check") do
  /NOT OK - false/ =~ output
end

check("Failed at_exit message") do
  /FAILURE/ =~ output
end

check("Successful at_exit message") do
  /Success/ =~ run_isolated{check("true"){true}}
end

check("Uncaught exception") do
  /FAILURE/ =~ run_isolated{raise 'Test'}
end

check("No check output") do
  /ok/ !~ run_isolated{check("true"){true}}
end