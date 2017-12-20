_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day13' )

data = aoc.parse2DIntArray( data, ': ' )

fw = []
fw[d[0]] = d[1] for d in data

depth = data[data.length - 1][0]

hitModulo = ( depth )->
  return 1 if depth == 1
  return 2 if depth == 2
  return (depth * 2) - 2

run = ( offset = 0 )->
  cost = 0
  hits = 0
  for pos in [0..depth]
    continue unless fw[pos]?
    if (pos + offset) % hitModulo( fw[pos] ) == 0
      cost += pos * fw[pos]
      hits++
  return {cost, hits}

console.log "Cost: #{run( ).cost}"
offset = 0
while true
  if run( offset ).hits == 0
    console.log "Offset: #{offset}"
    process.exit( 0 )
  offset++