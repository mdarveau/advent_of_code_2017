_ = require( 'lodash' )
aoc = require( './aoc_util' )

a = 679
b = 771

match = 0
for x in [0..40000000 - 1]
  console.log "#{(x / 40000000)*100}%" if x % 100000 == 0
  nextA = (a * 16807) % 2147483647
  nextB = (b * 48271) % 2147483647
  a = nextA
  b = nextB

  match++ if (a & 0xFFFF) == (b & 0xFFFF)

console.log "Matches: " + match