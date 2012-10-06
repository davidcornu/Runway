errors     = require('./errors')
RunwayType = require('./type')
_          = require('lodash')

class RunwayArray extends RunwayType

  default: -> []

  isCorrectType: _.isArray

  coerce: (thing) ->
    if _.isString(thing) or _.isBoolean(thing) or _.isNumber(thing)
      return [thing]
    else
      throw new errors.ConversionError

  isBlank: -> @value.length == 0

module.exports = RunwayArray