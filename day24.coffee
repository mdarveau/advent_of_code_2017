_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day24' )

data = aoc.parse2DIntArray( data, '/' )

maxStrength = 0
longest = 0
longestStrength = 0

getBridgeStrength = ( portList ) ->
  sum = 0
  for port in portList
    sum += port[0] + port[1]
  return sum

buildBridge = ( portSize, availablePorts, usedPorts ) ->
  strength = getBridgeStrength( usedPorts )
  if strength > maxStrength
    maxStrength = strength
    
  if usedPorts.length >= longest
    longest = usedPorts.length
    if strength > longestStrength
      longestStrength = strength

  for availablePort, index in availablePorts
    if availablePort[0] == portSize or availablePort[1] == portSize
      usedPorts.push( availablePort )
      availablePorts.splice( index, 1 )
      buildBridge( (if availablePort[0] == portSize then availablePort[1] else availablePort[0]), availablePorts, usedPorts )
      usedPorts.pop( )
      availablePorts.splice( index, 0, availablePort )

buildBridge( 0, data, [] )

console.log "(A) Max strength: #{maxStrength}"
console.log "(B) Longest is #{longest} long with a strength of #{longestStrength} "