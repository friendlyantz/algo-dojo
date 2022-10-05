require 'ruby-progressbar'

progress = ProgressBar.create(total: 100)
100.times do
  sleep 0.2
  # puts 'Hey'
  progress.increment
end