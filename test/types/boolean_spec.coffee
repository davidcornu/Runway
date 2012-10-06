assert  = require('assert')
path    = require('path')

baseDir = path.resolve(__dirname, '../../')

RunwayBoolean = require(path.join(baseDir, 'lib', 'runway', 'types', 'boolean'))
errors        = require(path.join(baseDir, 'lib', 'runway', 'types', 'errors'))

describe 'RunwayBoolean', ->

  it 'can be created with a boolean', ->
    for bool in [true, false]
      b = new RunwayBoolean(bool)
      assert(b.value == bool)

  it 'can be created with a string representation of a boolean', ->
    b = new RunwayBoolean('true')
    assert(b.value == true)

  it 'removes white space before converting strings', ->
    b = new RunwayBoolean('  f a l s e   ')
    assert(b.value == false)

  it 'cannot be created with an invalid string', ->
    assert.throws ->
      b = new RunwayBoolean('doodah')
    , errors.ConversionError

  it 'cannot be created with anything but a number or string representation', ->
    for intruder in [new Date, new Function, {}, []]
      assert.throws ->
        b = new RunwayBoolean(intruder)
      , errors.ConversionError

  it 'should return correct result for isBlank', ->
    b = new RunwayBoolean()
    assert(b.isBlank())