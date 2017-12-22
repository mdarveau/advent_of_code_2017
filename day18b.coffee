_ = require( 'lodash' )
aoc = require( './aoc_util' )

#data = require( './data/day18_test' )
data = require( './data/day18' )

data = aoc.parseArray( data, '\n' )

data = data.map ( d )->d.split( ' ' )

initProgram = ( id )->
  program = {
    id: id
    cursor: 0
    registers: {}
    ended: false
    queue: []
    sendCount: 0
  }
  program.readValue = ( v )->
    i = parseInt( v )
    return if isNaN( i ) then program.registers[v] else i

  program.readQueue = ->
    program.queue.shift()

  program.writeQueue = ( v ) ->
    program.queue.push v

  for p in [0..25]
    program.registers[String.fromCharCode( 'a'.charCodeAt( ) + p )] = 0

  program.registers['p'] = id

  # Return false when blocked
  program.runStep = ( otherProgram ) ->
    line = data[program.cursor]
    switch line[0]
      when 'snd'
        program.sendCount++
        otherProgram.writeQueue( program.readValue( line[1] ) )
      when 'set'
        program.registers[line[1]] = program.readValue( line[2] )
      when 'add'
        program.registers[line[1]] += program.readValue( line[2] )
      when 'mul'
        program.registers[line[1]] *= program.readValue( line[2] )
      when 'mod'
        program.registers[line[1]] %= program.readValue( line[2] )
      when 'rcv'
        received = program.readQueue( )
        return false unless received?
        program.registers[line[1]] = received
      when 'jgz'
        if program.readValue( line[1] ) > 0
          program.cursor += program.readValue( line[2] )
          program.cursor--

    program.cursor++

    program.ended = program.cursor < 0 or program.cursor >= data.length

    return true

  return program


p0 = initProgram( 0 )
p1 = initProgram( 1 )

while not p0.ended or not p1.ended
  p0blocked = if p0.ended then true else not p0.runStep( p1 )
  p1blocked = if p1.ended then true else not p1.runStep( p0 )
  if p0blocked and p1blocked
    break

console.log "Program 1 sent #{p1.sendCount} values"

