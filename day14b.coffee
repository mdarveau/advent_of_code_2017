_ = require( 'lodash' )
aoc = require( './aoc_util' )

input = "nbysizxe"

computeKnotHash = ( input )->
  listSize = 256
  data = []
  for x in [0..input.length - 1]
    data.push input.charCodeAt( x )
  data.push 17
  data.push 31
  data.push 73
  data.push 47
  data.push 23

  list = []
  list.push x for x in [0..listSize - 1]

  position = 0
  skipSize = 0

  run = ->
    for len in data
      subString = []
      subString.push( list[(position + x) % listSize] ) for x in [0..len - 1]
      subString.reverse( )
      list[(position + x) % listSize] = subString[x] for x in [0..len - 1]

      position += len + skipSize
      skipSize++

  run( ) for x in [0..63]

  denseHash = ""
  for x in [0..15]
    xor = list[16 * x]
    for y in [1..15]
      xor ^= list[(16 * x) + y]
    denseHash += ("00000000" + xor.toString( 2 )).substr( -8 )

  return denseHash

hashes = []
for row in [0..127]
  hashes.push computeKnotHash( input + "-" + row ).split( '' )

flipRegion = ( x, y ) ->
  return if x < 0 or y < 0 or x > 127 or y > 127
  return if hashes[x][y] == '0'
  hashes[x][y] = '0'
  flipRegion( x + 1, y )
  flipRegion( x - 1, y )
  flipRegion( x, y + 1 )
  flipRegion( x, y - 1 )

count = 0
for x in [0..127]
  for y in [0..127]
    if hashes[x][y] == '1'
      count++
      flipRegion( x, y )
console.log count