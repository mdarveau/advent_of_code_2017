_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day22' )

data = aoc.parse2DArray( data, '' )

infected = {}
for l in [0..data.length-1]
  for c in [0..data[l].length-1]
    infected["#{c}_#{l}"] = true if data[l][c] == '#'

directions = [[0, -1], [1, 0], [0, 1], [-1, 0]]
directionIndex = 0
position = [Math.ceil(data.length/2)-1, Math.ceil(data.length/2)-1]

infection = 0
for burstNo in [1..10000]
  if infected["#{position[0]}_#{position[1]}"]
    directionIndex++
  else
    directionIndex--
    infection++
  directionIndex = (directionIndex + directions.length) % directions.length
  infected["#{position[0]}_#{position[1]}"] = not infected["#{position[0]}_#{position[1]}"]
  position[0] += directions[directionIndex][0]
  position[1] += directions[directionIndex][1]

console.log "Infections: #{infection}"
