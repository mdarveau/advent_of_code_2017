_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day23a' )

data = aoc.parseArray( data, '\n' )

data = data.map (d)->d.split(' ')

cursor = 0
registers = {}
for p in [0..7]
  registers[String.fromCharCode('a'.charCodeAt() + p)] = 0

readValue = (v)->
  i = parseInt(v)
  return if isNaN(i) then registers[v] else i

mulExecutions = 0
    
while cursor >= 0 and cursor<data.length
  line = data[cursor]
  switch line[0]
    when 'set'
      registers[line[1]] = readValue( line[2] )
      cursor++
    when 'sub'
      registers[line[1]] -= readValue( line[2] )
      cursor++
    when 'mul'
      mulExecutions++
      registers[line[1]] *= readValue( line[2] )
      cursor++
    when 'jnz'
      if readValue( line[1] ) != 0
        cursor += readValue( line[2] )
      else
        cursor++

console.log "mul executions: #{mulExecutions}"