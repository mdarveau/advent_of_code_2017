_ = require( 'lodash' )
aoc = require( './aoc_util' )

state = 'A'
instructions = 
  A: [[1, 1, 'B'],[0, 1, 'C']]
  B: [[0, -1, 'A'],[0, 1, 'D']]
  C: [[1, 1, 'D'],[1, 1, 'A']]
  D: [[1, -1, 'E'],[0, -1, 'D']]
  E: [[1, 1, 'F'],[1, -1, 'B']]
  F: [[1, 1, 'A'],[1, 1, 'E']]  
nbSteps = 12368930

tape = {}
cursor = 0

for step in [1..nbSteps]
  value = tape[cursor] ? 0
  instruction = instructions[state][value]
  tape[cursor] = instruction[0]
  cursor += instruction[1]
  state = instruction[2]
  
sum = 0
for value in _.values(tape)
  sum += value
  
console.log "Checksum: #{sum}"