require 'ice_nine'
require 'pry'

MyStruct = Struct.new(:data)

LIST = MyStruct
       .new(
         [1, 'stuff', 32.32]
       )
       .freeze

LIST.data << 'new content that bypasses std shallow freezing'

IceNine.deep_freeze(LIST)

begin
  LIST.data << 'another content that shall not pass'
rescue FrozenError
  p 'it did not pass!'
end

# binding.pry
double = LIST.dup
p LIST.data.object_id
p double.data.object_id
p LIST
p double
double.data = 'new object'
p double.data.object_id
p double
