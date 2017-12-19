_ = require( 'lodash' )
aoc = require( './aoc_util' )

listSize = 256
input = "206,63,255,131,65,80,238,157,254,24,133,2,16,0,1,3"
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
  denseHash += ("00" + xor.toString(16)).substr(-2)
  
console.log "B: " + denseHash

#charCodeAt