assert  = require('assert')
path    = require('path')

baseDir = path.resolve(__dirname, '../../')

RunwayNumber = require(path.join(baseDir, 'lib', 'runway', 'types', 'number'))
errors       = require(path.join(baseDir, 'lib', 'runway', 'types', 'errors'))

describe 'RunwayNumber', ->

  it 'can be created with a number', ->
    n = new RunwayNumber(10)
    assert(n.value == 10)

  it 'can be created with a string representation of an integer', ->
    n = new RunwayNumber('11')
    assert(n.value == 11)

  it 'can be created with a string representation of a float', ->
    n = new RunwayNumber('10.1')
    assert(n.value == 10.1)

  it 'removes white space before converting strings', ->
    n = new RunwayNumber('  10  .  1   ')
    assert(n.value == 10.1)

  it 'cannot be created with an invalid string', ->
    assert.throws ->
      n = new RunwayNumber('doodah')
    , errors.ConversionError

  it 'cannot be created with anything but a number or string representation', ->
    for intruder in [new Date, new Function, {}, []]
      assert.throws ->
        n = new RunwayNumber(intruder)
      , errors.ConversionError

  it 'should return correct result for isBlank', ->
    n = new RunwayNumber()
    assert(n.isBlank())