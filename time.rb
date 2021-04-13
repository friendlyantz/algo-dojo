# require 'date'

p start = Time.now
p finish = start + (2*60*60) + 70

@timeElapsed = finish - start


p seconds = @timeElapsed % 60
 
#find the minutes
p minutes = (@timeElapsed / 60) % 60

#find the hours
p hours = (@timeElapsed/3600)

p formatted_duration =  format("%02d",hours) + " HRS " + format("%02d",minutes) + " MIN " + format("%02d",seconds) + " SEC"
