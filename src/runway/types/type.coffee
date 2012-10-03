_      = require('lodash')
errors = require('../errors')

class Type

  default: -> null

  constructor: (thing = null) ->
    @set(thing)
    @changed = false

  isCorrectType: (thing) -> false

  coerce: (thing) ->
    throw new errors.ConversionError

  set: (thing) ->
    if _.isNull(thing)
      @value = @default()
    else
      if @isCorrectType(thing)
        @value = thing
      else
        @value = @coerce(thing)
    @changed = true

  isBlank: -> !@value

module.exports = Type