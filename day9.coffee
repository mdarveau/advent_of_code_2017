_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day9' )

#data = aoc.parseArray( data, '\n' )
#data = aoc.parseIntArray( data, '\t' )
#data = aoc.parseFloatArray( data, '\n' )
#data = aoc.parse2DIntArray( data, '\t' )
#data = aoc.parse2DIntArray( data, '\t' )
#data = aoc.parse2DIntArray( data, '\t' )

#data = "<{o\"i!a,<{i<a>"

x = 0
garbage = false
currentGroupValue = 0
totalGroupsValue = 0
garbageCount = 0
while x < data.length
  switch data.charAt(x)
    when '{'
      currentGroupValue++ unless garbage
      garbageCount++ if garbage
    when '}'
      totalGroupsValue += currentGroupValue unless garbage
      currentGroupValue-- unless garbage
      garbageCount++ if garbage
    when '<'
      garbageCount++ if garbage
      garbage = true unless garbage
    when '>'
      garbage = false
    when '!'
      x++
    else  
      garbageCount++ if garbage
  x++
  
console.log "Group values: " + totalGroupsValue
console.log "Garbage: " + garbageCount