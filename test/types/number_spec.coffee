assert  = require('assert')
path    = require('path')

baseDir = path.resolve(__dirname, '../../')

Number  = require(path.join(baseDir, 'lib', 'runway', 'types', 'number'))
errors  = require(path.join(baseDir, 'lib', 'runway', 'errors'))

describe 'Number', ->

  it 'can be created with a number', ->
    n = new Number(10)
    assert(n.value == 10)

  it 'can be created with a string representation of an integer', ->
    n = new Number('11')
    assert(n.value == 11)

  it 'can be created with a string representation of a float', ->
    n = new Number('10.1')
    assert(n.value == 10.1)

  it 'removes white space before converting strings', ->
    n = new Number('  10  .  1   ')
    assert(n.value == 10.1)

  it 'cannot be created with an invalid string', ->
    assert.throws ->
      n = new Number('doodah')
    , errors.ConversionError

  it 'cannot be created with anything but a number or string representation', ->
    for intruder in [new Date, new Function, {}, []]
      assert.throws ->
        n = new Number(intruder)
      , errors.ConversionError

  it 'should return correct result for isBlank', ->
    n = new Number()
    assert(n.isBlank())