def jumpingOnClouds(c)
  counter = 0
  previous_cloud = ""
  c.each_with_index do |cloud, index|
      # print cloud.class
      index += 1
      cloud = cloud.to_i
      case cloud.to_i
          when 0
              puts index.to_s + ")safe:   ~~~ previous cloud:" + previous_cloud.to_s 
              p counter += 1 if previous_cloud == 0
              p counter += 1 if index == 0
          when 1
              puts index.to_s + ")stormy! -/-/-"
              p counter +=1
      end
      previous_cloud = cloud
  end
  puts counter
end

c = %w(0 0 1 0 0 1 0)
# 0 -- 1 --x-- 3 --4 --x-- 6
jumpingOnClouds(c)