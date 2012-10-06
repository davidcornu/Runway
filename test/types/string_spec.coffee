assert  = require('assert')
path    = require('path')

baseDir = path.resolve(__dirname, '../../')

RunwayString = require(path.join(baseDir, 'lib', 'runway', 'types', 'string'))
errors       = require(path.join(baseDir, 'lib', 'runway', 'types', 'errors'))

describe 'RunwayString', ->

  it 'can be created with a string', ->
    s = new RunwayString('string')
    assert(s.value == 'string')

  it 'can be created with a coerced boolean', ->
    s = new RunwayString(true)
    assert(s.value == 'true')

  it 'can be created with a coerced number', ->
    s = new RunwayString(10.01)
    assert(s.value == '10.01')

  it 'can be created with a coerced date', ->
    d = new Date
    s = new RunwayString(d)
    assert(s.value == '' + d)

  it 'cannot be created with anything but a string, boolean, number or date', ->
    for intruder in [new Function, {}, []]
      assert.throws ->
        s = new RunwayString(intruder)
      , errors.ConversionError

  it 'should default to an empty string', ->
    s = new RunwayString
    assert(s.value == '')

  it 'should return correct result for isBlank', ->
    s = new RunwayString()
    assert(s.isBlank())