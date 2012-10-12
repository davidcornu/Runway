_ = require('lodash')

coercionError = -> new Error('Coercion error')

module.exports =
  array: (thing) ->
    return thing if _.isArray(thing) or _.isNull(thing)
    if _.isString(thing) or _.isBoolean(thing) or _.isNumber(thing)
      return [thing]
    else
      throw coercionError()

  number: (thing) ->
    return thing if _.isNumber(thing) or _.isNull(thing)

    throw coercionError() unless _.isString(thing)

    stripped = thing.replace(/\s+/g, '')
    isInt    = /^\d+$/.test(stripped)
    isFloat  = /^\d+\.\d+$/.test(stripped)

    throw coercionError() unless isInt or isFloat

    attempt = if isInt then parseInt(stripped) else parseFloat(stripped)

    throw coercionError() if _.isNaN(attempt)

    return attempt

  boolean: (thing) ->
    return thing if _.isBoolean(thing) or _.isNull(thing)

    throw coercionError() unless _.isString(thing)

    stripped = thing.replace(/\s+/g, '')

    switch stripped
      when 'true'
        return true
      when 'false'
        return false
      else
        throw coercionError()

  string: (thing) ->
    return thing if _.isString(thing) or _.isNull(thing)

    if _.isNumber(thing) or _.isBoolean(thing) or _.isDate(thing)
      return "" + thing
    else
      throw coercionError()

  object: (thing) ->
    return thing if _.isObject(thing) or _.isNull(thing)
    throw coercionError()

