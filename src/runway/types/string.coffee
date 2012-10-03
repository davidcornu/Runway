errors = require('../errors')
Type   = require('./type')
_      = require('lodash')

class String extends Type

  default: -> ''

  isCorrectType: _.isString

  coerce: (thing) ->
    if _.isNumber(thing) or _.isBoolean(thing) or _.isDate(thing)
      return "" + thing
    else
      throw new errors.ConversionError

    stripped = thing.replace(/\s+/g, '')

    switch stripped
      when 'true'
        return true
      when 'false'
        return false
      else

  isBlank: -> @value.length == 0

module.exports = String