_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day8' )

data = aoc.parseArray( data, '\n' )
#data = aoc.parseIntArray( data, '\t' )
#data = aoc.parseFloatArray( data, '\n' )
#data = aoc.parse2DIntArray( data, '\t' )
#data = aoc.parse2DIntArray( data, '\t' )
#data = aoc.parse2DIntArray( data, '\t' )

data = data.map ( d )->
  r = d.split( ' ' )
  {
    register: r[0]
    instruction: r[1]
    amount: parseInt( r[2] )
    condition: {
      register: r[4]
      predicat: r[5]
      value: parseInt( r[6] )
    }
  }

registers = {}

for d in data
  registers[d.register] = 0

max = 0

for d in data
  valid = eval( "registers['#{d.condition.register}'] #{d.condition.predicat} #{d.condition.value}" )
  if valid
    registers[d.register] += if d.instruction == 'inc' then d.amount else d.amount * -1
    max = _.max( _.values(registers) ) if _.max( _.values(registers) ) > max

console.log "A: " + _.max( _.values(registers) )
console.log "B: " + max