$check_ok = true
$check_all_messages = false

if ARGV[0] == '--check-all-messages'
  ARGV.shift
  $check_all_messages = true
end

def check(what)
  if yield
    STDERR.puts "  ok - #{what}" if $check_all_messages
  else
    STDERR.puts "  NOT OK - #{what}"
    $check_ok = false
  end
end

at_exit do
  if $check_ok and not $!
    STDERR.puts "Success"
  else
    STDERR.puts "!!! FAILURE"
  end
end
