_ = require( 'lodash' )
aoc = require( './aoc_util' )

input =  244521

size = 1
while true
  break if Math.pow( size, 2 ) > input
  size += 2
console.log "#{size}x#{size} matrix"
center = (size - 1) / 2
console.log "Center: #{center}"

m = []
for x in [1..size]
  m.push new Array( size )

# right, up, left, down
moves = [ [ 1, 0 ], [ 0, 1 ], [ -1, 0 ], [ 0, -1 ] ]
movesIndex = 0
moveLength = 1

x = y = center
square = 1
m[x][y] = square
while m[x][y] <= input
  for i in [0..1]
    for j in [0..moveLength - 1]
      x += moves[movesIndex][0]
      y += moves[movesIndex][1]
      value = 0
      for i in [ -1, 0, 1 ]
        for j in [ -1, 0, 1 ]
          value += m[x + i]?[y + j] ? 0
      m[x][y] = value
      if value > input
        console.log "Value: #{value}"
        process.exit( 0 )
    movesIndex = (movesIndex + 1) % 4
  moveLength++