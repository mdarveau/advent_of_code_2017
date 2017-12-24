_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day22' )

data = aoc.parse2DArray( data, '' )

states = {}
for l in [0..data.length-1]
  for c in [0..data[l].length-1]
    states["#{c}_#{l}"] = if data[l][c] == '#' then 'I' else 'C'

directions = [[0, -1], [1, 0], [0, 1], [-1, 0]]
directionIndex = 0
position = [Math.ceil(data.length/2)-1, Math.ceil(data.length/2)-1]

infection = 0
for burstNo in [1..10000000]
  switch states["#{position[0]}_#{position[1]}"]
    when 'W'
      states["#{position[0]}_#{position[1]}"] = 'I'
      infection++
    when 'I'
      states["#{position[0]}_#{position[1]}"] = 'F'
      directionIndex++
    when 'F'
      states["#{position[0]}_#{position[1]}"] = 'C'
      directionIndex += 2
    else
      # Clean or unset      
      directionIndex--
      states["#{position[0]}_#{position[1]}"] = 'W'
  
  directionIndex = (directionIndex + directions.length) % directions.length
  
  position[0] += directions[directionIndex][0]
  position[1] += directions[directionIndex][1]
  
console.log "Infections: #{infection}"
