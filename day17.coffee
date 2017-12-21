_ = require( 'lodash' )
aoc = require( './aoc_util' )

input = 324

buffer = [0]
position = 0

for step in [1..2017]
  insertPosition = (position + input) % buffer.length
  buffer.splice(insertPosition+1, 0, step)
  position = insertPosition+1
  
console.log "A: " + buffer[position+1]

bufferLength = 1
position = 0
afterZero = undefined
for step in [1..50000000]
  insertPosition = (position + input) % bufferLength
  afterZero = step if insertPosition == 0
  position = insertPosition+1
  bufferLength++
  
console.log "B: " + afterZero 