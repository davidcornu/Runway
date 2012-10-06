errors     = require('./errors')
RunwayType = require('./type')
_          = require('lodash')

class RunwayBoolean extends RunwayType

  isCorrectType: _.isBoolean

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

module.exports = RunwayBoolean