assert  = require('assert')
path    = require('path')

baseDir = path.resolve(__dirname, '../../')

Type    = require(path.join(baseDir, 'lib', 'runway', 'types', 'type'))
errors  = require(path.join(baseDir, 'lib', 'runway', 'errors'))

describe 'Type', ->

  it 'has a null value if nothing is passed', ->
    n = new Type()
    assert(n.value == null)