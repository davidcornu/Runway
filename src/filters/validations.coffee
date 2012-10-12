_ = require('lodash')

module.exports =
  isPresent: (thing) ->
    throw new Error('Required') if _.isNull(thing)

  isLongerThan: (length) ->
    return (thing) ->
      if thing && thing.length <= length
        throw new Error('Is too short')

  isShorterThan: (length) ->
    return (thing) ->
      if thing && thing.length >= length
        throw new Error('Is too long')