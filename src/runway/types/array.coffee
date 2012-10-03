errors = require('../errors')
Type   = require('./type')
_      = require('lodash')

class Array extends Type

  default: -> []

  isCorrectType: _.isArray

  coerce: (thing) ->
    throw new errors.ConversionError unless _.isString(thing)

    stripped = thing.replace(/\s+/g, '')

    switch stripped
      when 'true'
        return true
      when 'false'
        return false
      else
        throw new errors.ConversionError

  isBlank: -> @value.length == 0

module.exports = Array