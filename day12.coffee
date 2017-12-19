_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day12' )

data = aoc.parseArray( data, '\n' )

data = data.map ( d )->
  pipe = d.split( ' <-> ' )
  return {
    id: parseInt( pipe[0] )
    destinations: aoc.parseIntArray( pipe[1], ',' )
  }

#console.log data  

cache = {}

followPipe = ( pipe ) ->
  return 0 if cache[pipe.id]
  cache[pipe.id] = true
  return 1 + _.sum( pipe.destinations.map( ( d )->
    followPipe( _.find( data, {id: d} ) )
  ) )

console.log "Groups from id 0: " + followPipe( _.find( data, {id: 0} ) )

groupCount = 1
for pipe in data
  continue if cache[pipe.id]
  followPipe( pipe )
  groupCount++
  
console.log "Total group counts: #{groupCount}"