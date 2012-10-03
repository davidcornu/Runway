assert  = require('assert')
path    = require('path')

baseDir = path.resolve(__dirname, '../../')

String = require(path.join(baseDir, 'lib', 'runway', 'types', 'string'))
errors  = require(path.join(baseDir, 'lib', 'runway', 'errors'))

describe 'String', ->

  it 'can be created with a string', ->
    s = new String('string')
    assert(s.value == 'string')

  it 'can be created with a coerced boolean', ->
    s = new String(true)
    assert(s.value == 'true')

  it 'can be created with a coerced number', ->
    s = new String(10.01)
    assert(s.value == '10.01')

  it 'can be created with a coerced date', ->
    d = new Date
    s = new String(d)
    assert(s.value == '' + d)

  it 'cannot be created with anything but a string, boolean, number or date', ->
    for intruder in [new Function, {}, []]
      assert.throws ->
        s = new String(intruder)
      , errors.ConversionError

  it 'should default to an empty string', ->
    s = new String
    assert(s.value == '')

  it 'should return correct result for isBlank', ->
    s = new String()
    assert(s.isBlank())