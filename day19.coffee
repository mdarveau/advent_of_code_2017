_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day19' )

data = aoc.parse2DArray( data, '' )

position = {
  line: 0
  column: data[0].indexOf( '|' )
}
# line, column
# - = up or left
# + = down or right
direction = {line: 1, column: 0}

directions = [
  {line: -1, column: 0}
  {line: 1, column: 0}
  {line: 0, column: 1}
  {line: 0, column: -1}
]

isValidPosition = ( position )->
  v = data[position.line]?[position.column]
  return v != undefined and v != ' '

findNextPositionAndDirection = ( currentDirection, currentPosition ) ->
  for potentialDirection in directions
    continue if currentDirection.line == -potentialDirection.line and currentDirection.column == -potentialDirection.column
    nextPosition = {
      line: currentPosition.line + potentialDirection.line
      column: currentPosition.column + potentialDirection.column
    }
    if isValidPosition( nextPosition )
      return [ nextPosition, potentialDirection ]

path = []
steps = 0

while true
  steps++
  nextPosition = {
    line: position.line + direction.line
    column: position.column + direction.column
  }
  if isValidPosition( nextPosition )
    position = nextPosition
    value = data[position.line][position.column]
    path.push( value ) unless value == '|' or value == '-' or value == '+'
  else
    res = findNextPositionAndDirection( direction, position )
    break unless res?
    [position, direction] = res

console.log path.join('')
console.log steps