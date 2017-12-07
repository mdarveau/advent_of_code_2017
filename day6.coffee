_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day6' )

#data = aoc.parseArray( data, '\n' )
data = aoc.parseIntArray( data, '\t' )
#data = aoc.parseFloatArray( data, '\n' )
#data = aoc.parse2DIntArray( data, '\t' )
#data = aoc.parse2DIntArray( data, '\t' )
#data = aoc.parse2DIntArray( data, '\t' )

findHigh = (data)->
  max = 0
  index = 0
  for d, x in data
    if d > max
      index = x 
      max = d
  return index

history = {}
  
count = 0
while true
  count++
  block = findHigh(data)
  nb = data[block]
  data[block] = 0
  for x in [1..nb]
    block++
    data[block % data.length]++
  hash = data.join(',')
  if history[hash]
    console.log "a:" + count
    console.log "b:" + (count - history[hash])
    process.exit( 0 )
  history[hash] = count
  
