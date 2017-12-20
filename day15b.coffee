_ = require( 'lodash' )
aoc = require( './aoc_util' )

a = 679
b = 771

generate = ( previous, multiplier, modulo) ->
  next = (previous * multiplier) % 2147483647
  return next if next % modulo == 0
  generate( next, multiplier, modulo)

match = 0
for x in [0..5000000 - 1]
  console.log "#{(x / 5000000)*100}%" if x % 100000 == 0
  nextA = generate(a, 16807, 4)
  nextB = generate(b, 48271, 8)
  a = nextA
  b = nextB

  match++ if (a & 0xFFFF) == (b & 0xFFFF)

console.log "Matches: " + match