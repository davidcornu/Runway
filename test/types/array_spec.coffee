assert  = require('assert')
path    = require('path')
_       = require('lodash')

baseDir = path.resolve(__dirname, '../../')

RunwayArray = require(path.join(baseDir, 'lib', 'runway', 'types', 'array'))
errors      = require(path.join(baseDir, 'lib', 'runway', 'types', 'errors'))

describe 'RunwayArray', ->

  it 'can be created with an Array', ->
    a = new RunwayArray([1,2,3])
    assert(_.isArray(a.value))

  it 'defaults to an empty Array', ->
    a = new RunwayArray()
    assert(_.isArray(a.value))
    assert(a.value.length == 0)

  it 'coerces booleans, numbers and strings into arrays', ->
    for value in ["hello", true, 14]
      a = new RunwayArray(value)
      assert(_.isArray(a.value))
      assert(a.value[0] == value)

  it 'cannot be created with a date, function or object', ->
    for intruder in [new Date, new Function, {}]
      assert.throws ->
        a = new RunwayArray(intruder)
      , errors.ConversionError

  it 'should return correct result for isBlank', ->
    a = new RunwayArray()
    assert(a.isBlank())