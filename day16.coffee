_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day16' )

data = aoc.parseArray( data, ',' )
#data = aoc.parseIntArray( data, '\t' )
#data = aoc.parseFloatArray( data, '\n' )
#data = aoc.parse2DIntArray( data, '\t' )
#data = aoc.parse2DIntArray( data, '\t' )
#data = aoc.parse2DIntArray( data, '\t' )

buildSpin = ( count ) ->
  ( dance ) ->
#    console.log "Spin #{count}"
    return (dance.substr(-count) + dance).substr(0, dance.length)
    

buildExchange = ( i1, i2 ) ->
  ( dance ) ->
    if i1 > i2
      t = i2
      i2 = i1
      i1 = t
#    console.log "Exchange #{i1}, #{i2}"
    v1 = dance.charAt(i1)
    v2 = dance.charAt(i2)
    return dance.substr(0, i1) + v2 + dance.substring(i1+1, i2) + v1 + dance.substr(i2+1)

buildPartner = ( a, b ) ->
  ( dance ) ->
#    console.log "Partner #{a}, #{b}"
    return buildExchange(dance.indexOf(a), dance.indexOf(b))(dance)

data = data.map ( d )->
  switch d.charAt( 0 )
    when 's'
      buildSpin( parseInt( d.substr( 1 ) ) )
    when 'x'
      buildExchange( parseInt( d.substr( 1 ).split( '/' )[0] ), parseInt( d.substr( 1 ).split( '/' )[1] ) )
    when 'p'
      buildPartner( d.substr( 1 ).split( '/' )[0], d.substr( 1 ).split( '/' )[1] )

dance = []
for p in [0..15]
  dance.push String.fromCharCode('a'.charCodeAt() + p)
dance = dance.join('')

runDance = (dance) ->
  for d in data
    dance = d(dance)
  return dance
  
console.log "A: " + runDance(dance)

cache = {}
cache[dance] = 0

round = 1
target = 1000000000
opt = false
while round < target
  console.log "#{(round / target)*100}%" if round % 1000 == 0
  dance = runDance(dance)
  if cache[dance]? and not opt
    opt = true
    loopSource = cache[dance]
    hopSize = round - loopSource
    console.log "Found a loop at round #{round} with #{dance}!"
    console.log "Found source: #{loopSource}"
    console.log "Hop size: #{hopSize}"
    round = loopSource + (Math.floor((target-loopSource) / hopSize) * hopSize)
    console.log "Skipping to: #{round}"
  
  cache[dance] = round
  round++
  
console.log "B: " + runDance(dance)