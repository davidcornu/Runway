path      = require('path')
assert    = require('assert')

basePath  = path.resolve(__dirname, '../')
Runway    = require(path.join(basePath, 'lib/runway'))

describe 'Runway', ->
  it 'should return true', ->
    assert(true)