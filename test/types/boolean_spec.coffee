assert  = require('assert')
path    = require('path')

baseDir = path.resolve(__dirname, '../../')

Boolean = require(path.join(baseDir, 'lib', 'runway', 'types', 'boolean'))
errors  = require(path.join(baseDir, 'lib', 'runway', 'errors'))

describe 'Boolean', ->

  it 'can be created with a boolean', ->
    for bool in [true, false]
      b = new Boolean(bool)
      assert(b.value == bool)

  it 'can be created with a string representation of a boolean', ->
    b = new Boolean('true')
    assert(b.value == true)

  it 'removes white space before converting strings', ->
    b = new Boolean('  f a l s e   ')
    assert(b.value == false)

  it 'cannot be created with an invalid string', ->
    assert.throws ->
      b = new Boolean('doodah')
    , errors.ConversionError

  it 'cannot be created with anything but a number or string representation', ->
    for intruder in [new Date, new Function, {}, []]
      assert.throws ->
        b = new Boolean(intruder)
      , errors.ConversionError

  it 'should return correct result for isBlank', ->
    b = new Boolean()
    assert(b.isBlank())