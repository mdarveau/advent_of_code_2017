_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day21' )

data = aoc.parseArray( data, '\n' )

#../.. => #../##./...
data = data.map ( d )->
  d = d.split( ' => ' )
  {
    input: aoc.parseArray( d[0], '/' ).map ( s )->s.split( '' )
    inputs: []
    output: aoc.parseArray( d[1], '/' ).map ( s )->s.split( '' )
  }

createPicture = ( size )->
  picture = []
  picture[x] = [] for x in [0..size - 1]
  return picture

print = ( p )->
  delimiter = new Array( p.length + 3 ).join( '-' )
  console.log delimiter
  for l in p
    console.log " " + l.join( '' )
  console.log delimiter

flipH = ( p ) ->
  size = p.length
  out = createPicture( size )
  for l in [0..size - 1]
    for c in [0..size - 1]
      out[l][size - 1 - c] = p[l][c]
  return out

flipV = ( p ) ->
  size = p.length
  out = createPicture( size )
  for l in [0..size - 1]
    for c in [0..size - 1]
      out[size - 1 - l][c] = p[l][c]
  return out

rotate = ( p ) ->
  size = p.length
  out = createPicture( size )
  for l in [0..size - 1]
    for c in [0..size - 1]
      out[c][size - 1 - l] = p[l][c]
  return out

for d in data
  pattern = d.input
  for x in [0..3]
    d.inputs.push pattern
    d.inputs.push flipH( pattern )
    d.inputs.push flipV( pattern )
    pattern = rotate( pattern )

isMatch = ( picture, lOffset, cOffset, pattern ) ->
  size = pattern.length
  for l in [0..size - 1]
    for c in [0..size - 1]
      return false unless picture[l + lOffset][c + cOffset] == pattern[l][c]
  return true

findMatch = ( picture, matchSize, lOffset, cOffset )->
  for d in data
    for input in d.inputs
      if input.length == matchSize
        return d.output if isMatch( picture, lOffset, cOffset, input )

run = (nbIterations)->
  picture = aoc.parseArray( ".#./..#/###", '/' ).map ( s )->s.split( '' )
  for iteration in [0..nbIterations-1]
    matchSize = if picture.length % 2 == 0 then 2 else 3
  
    nbSubPictures = picture.length / matchSize
    newPicture = createPicture( nbSubPictures * (matchSize + 1) )
    for subPictureL in [0..nbSubPictures - 1]
      for subPictureC in [0..nbSubPictures - 1]
        output = findMatch( picture, matchSize, subPictureL * matchSize, subPictureC * matchSize )
        unless output?
          console.log "Error, could not find match"
  
        for l in [0..output.length - 1]
          for c in [0..output.length - 1]
            newPicture[(subPictureL * (matchSize + 1)) + l][(subPictureC * (matchSize + 1)) + c] = output[l][c]
  
    picture = newPicture
#    console.log "Iteration #{iteration}"
#    print picture
  
  return picture

countOn = (picture) ->
  count = 0
  for l in [0..picture.length-1]
    for c in [0..picture.length-1]
      count++ if picture[l][c] == '#'
  return count

console.log "On after 5 iterations: " + countOn(run(5))
console.log "On after 18 iterations: " + countOn(run(18))