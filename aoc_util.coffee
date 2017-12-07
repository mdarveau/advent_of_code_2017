_ = require('lodash')

module.exports = {

  parseArray: ( data, delimiter = '\t' )->
    data = _.trimEnd( data, delimiter )
    data.split( delimiter )
  parseIntArray: ( data, delimiter = '\t' )-> module.exports.parseArray( data, delimiter ).map( ( d )->parseInt( d ) )
  parseFloatArray: ( data, delimiter = '\t' )-> module.exports.parseArray( data, delimiter ).map( ( d )->parseFloat( d ) )

  parse2DArray: ( data, delimiter = '\t', parser )->
    data = _.trimEnd( data, '\n' )
    data.split( '\n' ).map( ( d )->
      data = module.exports.parseArray( data, delimiter )
      res = d.split( delimiter )
      res = res.map( ( d )->parser( d ) ) if parser?
      return res
    )
  parse2DIntArray: ( data, delimiter = '\t' )-> module.exports.parse2DArray( data, delimiter, parseInt )
  parse2DFloatArray: ( data, delimiter = '\t' )-> module.exports.parse2DArray( data, delimiter, parseFloat )

  # Return all pairs of element of a matched to elements of b
  # Return [a_index, b_index, a_value, b_value] or an array with values refurned by f called with (a_index, b_index, a_value, b_value).
  expandArrays: ( a, b, f )->
    res = []
    for ai in [0..a.length-1]
      for bi in [0..b.length-1]
        res.push if f? then f(ai, bi, a[ai], b[bi]) else [ai, bi, a[ai], b[bi]]
    return res
 
  print2DArray: ( data ) ->
    for r in data
      console.log r.join(', ')
  
  hash2DArray: ( data ) ->
    hash = ""
    for r in data
      hash += "[#{r.join(',')}]"
    return hash
      
    
  # _.cloneDeep state
  # _.some(collection, [predicate=_.identity])
  # _.find(collection, [predicate=_.identity])
  # .charCodeAt(0)
  # .charAt(x)
  # .substr
  # _.orderBy( chars, ['count', 'charValue'], ['desc', 'asc'])
  # md5 = require('js-md5'); md5(something)
  # regex = "\\[[a-z]*(CAPTURE)[a-z]*\\]"; data.search(new RegExp(regex)) >= 0
  # Array: 
  #   unshift: add head
  #   shift: remove head
  #   push: add tail
  #   pop: remove tail
  # process.stdout.write
}