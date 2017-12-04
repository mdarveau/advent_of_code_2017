_ = require( 'lodash' )
aoc = require( './aoc_util' )

#input = 21
input = 265149

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
while square < input
  for i in [0..1]
    for j in [0..moveLength-1]
      x += moves[movesIndex][0]
      y += moves[movesIndex][1]
      m[x][y] = ++square
      if square == input
        console.log "x, y: #{x},#{y}"
        console.log "Distance: #{Math.abs(x-center) + Math.abs(y-center)}"
        break
    movesIndex = (movesIndex + 1) % 4
  moveLength++