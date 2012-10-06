errors     = require('./errors')
RunwayType = require('./type')
_          = require('lodash')

class RunwayString extends RunwayType

  default: -> ''

  isCorrectType: _.isString

  coerce: (thing) ->
    if _.isNumber(thing) or _.isBoolean(thing) or _.isDate(thing)
      return "" + thing
    else
      throw new errors.ConversionError

  isBlank: -> @value.length == 0

module.exports = RunwayString