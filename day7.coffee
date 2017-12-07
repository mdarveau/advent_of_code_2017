_ = require( 'lodash' )
aoc = require( './aoc_util' )

data = require( './data/day7' )

data = aoc.parseArray( data, '\n' )
#data = aoc.parseIntArray( data, '\t' )
#data = aoc.parseFloatArray( data, '\n' )
#data = aoc.parse2DIntArray( data, '\t' )
#data = aoc.parse2DIntArray( data, '\t' )
#data = aoc.parse2DIntArray( data, '\t' )

data = data.map ( d )->
  r = d.split( ' -> ' )
  r2 = r[0].split( ' (' )
  name = r2[0]
  weight = parseInt( r2[1].substring( 0, r2[1].length - 1 ) )
  childs = r[1]?.split( ', ' ) ? []
  return {name, weight, childs}

for d in data
  d.parent = _.find data, ( node )->
    _.includes node.childs, d.name

root = _.find data, ( node )->
  not node.parent?

console.log "Root: " + root.name

hash = {}
hash[d.name] = d for d in data

sumWeight = ( node ) ->
  childs = node.childs.map ( c ) -> hash[c]
  sumWeight( child ) for child in childs
  node.sumWeight = if childs? and childs.length != 0 then _.sumBy( childs, 'sumWeight' ) + node.weight else node.weight

checkBalance = ( node ) ->
  childs = node.childs.map ( c ) -> hash[c]
  for weight, number of _.countBy( childs, 'sumWeight' )
    if number == 1
      unbalanced = _.find(childs, {sumWeight: parseInt(weight)})
      unbalancedChild = checkBalance(unbalanced)
      if !unbalancedChild?
        # It's him -> unbalanced
        console.log "#{unbalanced.name}: new weight #{unbalanced.weight - (unbalanced.sumWeight - _.find(childs, (c)->c.sumWeight != weight).sumWeight)}"
        
      return unbalanced
  return null

sumWeight( root )

#for name, n of hash
#  console.log "#{name}->#{n.sumWeight}"

checkBalance( root )