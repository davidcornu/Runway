assert  = require('assert')
path    = require('path')

baseDir = path.resolve(__dirname, '../../')

RunwayType = require(path.join(baseDir, 'lib', 'runway', 'types', 'type'))
errors     = require(path.join(baseDir, 'lib', 'runway', 'types', 'errors'))

describe 'RunwayType', ->

  it 'has a null value if nothing is passed', ->
    n = new RunwayType()
    assert(n.value == null)