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

getDistance = ( p ) ->  Math.abs( p[0] ) + Math.abs( p[1] ) + Math.abs( p[2] )

for d in data
  d.distance = getDistance( d.p )

while true
  for d in data
    for x in [0..2]
      d.v[x] += d.a[x]
      d.p[x] += d.v[x]

  toRemove = []
  for x in [0..data.length-2]
    d = data[x]
    for y in [x+1..data.length-1]
      d2 = data[y]
      if d.p[0]==d2.p[0] and d.p[1]==d2.p[1] and d.p[2]==d2.p[2]
        toRemove.push d.id
        toRemove.push d2.id
  
  data = _.filter data, (d)-> not _.includes(toRemove, d.id)

  console.log data.length
  
  