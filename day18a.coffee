_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day18' )

data = aoc.parseArray( data, '\n' )

data = data.map (d)->d.split(' ')

cursor = 0
registers = {}
lastSound = null
for p in [0..25]
  registers[String.fromCharCode('a'.charCodeAt() + p)] = 0

readValue = (v)->
  i = parseInt(v)
  return if isNaN(i) then registers[v] else i

while cursor >= 0 and cursor<data.length
  line = data[cursor]
  switch line[0]
    when 'snd'
      lastSound = readValue( line[1] )
    when 'set'
      registers[line[1]] = readValue( line[2] )
    when 'add'
      registers[line[1]] += readValue( line[2] )
    when 'mul'
      registers[line[1]] *= readValue( line[2] )
    when 'mod'
      registers[line[1]] %= readValue( line[2] )
    when 'rcv'
      if readValue( line[1] ) != 0
        console.log "Recovered " + lastSound 
        process.exit( 0 )
    when 'jgz'
      if readValue( line[1] ) > 0
        cursor += readValue( line[2] )
        cursor--

  console.log "#{cursor}: #{JSON.stringify(registers)}"      
      
  cursor++