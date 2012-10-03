assert  = require('assert')
path    = require('path')
_       = require('lodash')

baseDir = path.resolve(__dirname, '../../')

Array   = require(path.join(baseDir, 'lib', 'runway', 'types', 'array'))
errors  = require(path.join(baseDir, 'lib', 'runway', 'errors'))

describe 'Array', ->

  it 'can be created with an array', ->
    a = new Array([1,2,3])
    assert(_.isArray(a.value))

  it 'defaults to an empty array', ->
    a = new Array()
    assert(_.isArray(a.value))
    assert(a.value.length == 0)

  it 'cannot be created with anything but an array', ->
    for intruder in [new Date, new Function, {}, "", true]
      assert.throws ->
        a = new Array(intruder)
      , errors.ConversionError

  it 'should return correct result for isBlank', ->
    a = new Array()
    assert(a.isBlank())