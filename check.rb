$ok = true

def check(what)
  if yield
    STDERR.puts "ok - #{what}"
  else
    STDERR.puts "NOT OK - #{what}"
    $ok = false
  end
end

at_exit do
  if $ok
    STDERR.puts "Success"
  else
    STDERR.puts "FAILURE"
  end
end
