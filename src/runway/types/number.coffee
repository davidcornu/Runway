errors     = require('./errors')
RunwayType = require('./type')
_          = require('lodash')

class RunwayNumber extends RunwayType

  isCorrectType: _.isNumber

  coerce: (thing) ->
    throw new errors.ConversionError unless _.isString(thing)

    stripped = thing.replace(/\s+/g, '')
    isInt    = /^\d+$/.test(stripped)
    isFloat  = /^\d+\.\d+$/.test(stripped)

    throw new errors.ConversionError unless isInt or isFloat

    attempt = if isInt then parseInt(stripped) else parseFloat(stripped)

    throw new errors.ConversionError if _.isNaN(attempt)

    return attempt

module.exports = RunwayNumber