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
