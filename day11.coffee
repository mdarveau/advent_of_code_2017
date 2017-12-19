_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day11' )

data = aoc.parseArray( data, ',' )

computeDistance = ( column, row ) ->
  column = Math.abs( column )
  row = Math.abs( row )
  steps = 0
  while not (column == 0 and row == 0)
    if column > 0
      # Diagonal move
      row = Math.abs( row ) - .5
      column -= 1
    else if column == 0
      row -= 1
    steps++
  return steps

row = 0
column = 0
maxDistance = 0
for d in data
  switch d
    when 'ne'
      row += .5
      column += 1
    when 'n'
      row += 1
    when 'nw'
      row += .5
      column -= 1
    when 'se'
      row -= .5
      column += 1
    when 's'
      row -= 1
    when 'sw'
      row -= .5
      column -= 1
  distance = computeDistance( column, row )
  maxDistance = distance if distance > maxDistance

console.log "row = #{row}, column = #{column}"
console.log "#{computeDistance( column, row )} steps"
console.log "Max distance: #{maxDistance}"