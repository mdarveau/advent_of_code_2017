_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day5' )

data = aoc.parseIntArray( data, '\n' )

steps = 0
index = 0
while true
  steps++
  value = data[index]
  if value >= 3
    data[index]--
  else
    data[index]++
  index += value
  if index >= data.length or index < 0
    console.log steps
    process.exit( 0 )