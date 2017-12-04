_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day4' )

data = aoc.parse2DArray(data, ' ', (d)->_.sortBy(d).join())

count = 0
for d in data
  duplicate = false
  for w, x in d
    for y in [x+1..d.length-1]
      break if y>=d.length
      if d[y] == w
        duplicate = true
  count++ unless duplicate
  
console.log count
    
