# catch/throw are NOT the same as raise/rescue.
# --raise, fail, rescue, and ensure handle errors/exceptions
# --throw and catch are control flow
# Unlike in other languages, Ruby’s throw and catch are not used for exceptions. Instead, they provide a way to terminate execution early when no further work is needed. (Grimm, 2011)
# While the exception mechanism of raise and rescue is great for abandoning execution when things go wrong, it’s sometimes nice to be able to jump out of some deeply nested construct during normal processing. This is where catch and throw come in handy. (Thomas and Hunt, 2001)
def power(n, p)
  # begin
  n**p
  raise 'n and p should be non-negative' if (n | p).negative?

end

puts power(-2,4)