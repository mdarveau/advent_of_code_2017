_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day20' )

data = aoc.parseArray( data, '\n' )

data = data.map ( d, idx )->
  res = /p=<(.*)>, v=<(.*)>, a=<(.*)>/g.exec( d )
  {
    id: idx
    p: aoc.parseIntArray( res[1], ',' )
    v: aoc.parseIntArray( res[2], ',' )
    a: aoc.parseIntArray( res[3], ',' )
  }

console.log data

getDistance = ( p ) ->  Math.abs( p[0] ) + Math.abs( p[1] ) + Math.abs( p[2] )

for d in data
  d.distance = getDistance( d.p )

while true
  for d in data
    for x in [0..2]
      d.v[x] += d.a[x]
      d.p[x] += d.v[x]
    d.distance = getDistance( d.p )

  closer = null
  for d in data
    closer = d if closer == null or Math.abs( d.distance ) < Math.abs( closer.distance )

  console.log closer.id
  
  