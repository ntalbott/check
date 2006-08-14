require 'check'

def run_isolated
  read, write = IO.pipe
  fork do
    read.close
    STDERR.reopen(write)
    $ok = true

    yield
  end
  write.close
  Process.wait
  read.read
end

output = run_isolated do
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
