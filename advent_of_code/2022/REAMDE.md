My awesome adventure with my friends on 2022 Advent of Code.
Here are my notes, takeaway, learnings, etc.

# File Structure
- 1 folder should contain everything for a challenge (unless some generic `lib` logic will be refactored into a separate helper file, which will be indicated by `require` for this solution)
- Specs located within the same folder, for an observer without Ruby knowledge to find everything in one place(in classic Ruby we generally have a `root` Spec folder, however this is inconvenient to jump around, using GitHub.

# File Loading
I use `__dir__` so the files can be gracefully loaded regardless of directory you initiate the programme.

__dir__ always ties to the file, unlike `./` which ties to your current directory position

```ruby
 File.join(__dir__, 'filename')
```

Alternative could be:

```ruby
$LOAD_PATH << __dir__
```

this will work with `require 'filename'`,

but it will pose a problem later in our spec `let` { File.read 'filename' },

also this would be hard to distinguish between files and Ruby `gems`

# Other solutions
https://github.com/seanhandley/adventofcode2022

https://github.com/astley92/advent_of_code/tree/main/2022

# Learnings

## D3
overlapping `item_1.chars & item_2.chars` - find common items in Arrays

## D4-5
pure TDD implementation is extremely rewarding!

## D6
was a good way again to test drive it and make a simple dumb code to pass the test, which allowed for beatiful refactoring and reminded me of `each_cons` method consecutive looping

### refactoring:
#### original
```ruby
  stack = ''
  data.chars.each_with_index do |char, i|
    stack = stack[1..-1] if stack.size.eql?(packet_size)
    stack << char

    return i + 1 if stack.chars.uniq.size.eql? packet_size
  end
```

##### refactoring 1
```ruby
  data.chars
    .each_cons(packet_size)
    .with_index do |stack, i|

      return packet_size + i if stack.uniq.size.eql? packet_size
  end
```
##### refactoring 2
```ruby
  data.chars
    .each_cons(packet_size)
    .with_index
    .find { |chars, i| chars.uniq.length == packet_size }
    .last + packet_size
```
##### refactoring 3
`==` and `.eql?` are not the same, eql also checks for type

`10.eql?(10.0) => false`
```ruby
  data.chars
    .each_cons(packet_size)
    .with_index
    .find { |chars, i| chars.uniq.eql? chars }
    .last + packet_size
```

## D8 Tree Map
do not skip tests! write more tests, if tests are green this doesn't mean it is 100% working
refactor, consider 99bottle chapter 5 rules for refactoring.
detect easiest code smell, remove it, make it open, refactor
## D9 rope bridge

```ruby 
array.first 
# AND
array[0]
```
are not the same, you cannot mutate / assign using `.first = 'new value'`
