_ = require( 'lodash' )
aoc = require( './aoc_util' )

listSize = 256
data = "206,63,255,131,65,80,238,157,254,24,133,2,16,0,1,3"

#listSize = 5
#data = "3,4,1,5"

#data = aoc.parseArray( data, '\n' )
data = aoc.parseIntArray( data, ',' )
#data = aoc.parseFloatArray( data, '\n' )
#data = aoc.parse2DIntArray( data, '\t' )
#data = aoc.parse2DIntArray( data, '\t' )
#data = aoc.parse2DIntArray( data, '\t' )


list = []
list.push x for x in [0..listSize-1]
  
position = 0
skipSize = 0

for len in data
  subString = []
  subString.push(list[(position + x) % listSize]) for x in [0..len-1]
  subString.reverse()
  list[(position + x) % listSize] = subString[x] for x in [0..len-1]
  
  console.log "#{list.join(',')}"
  
  position += len + skipSize
  skipSize++
  
console.log "A: " + (list[0] * list[1])