_           = require('lodash')
types       = require('./types')
errors      = require('./errors')

validTypes = _.keys(types)

class Schema

  constructor: (structure = {}) ->
    @mapping = {}
    @validations = []
    @add(structure)

  add: (structure) ->
    for attribute, type of structure
      if type in validTypes
        @mapping[attribute] = types[type]
      else if _.isObject(type)
        try
          @mapping[attribute] = new Schema(type)
        catch e
          e.message = attribute + ": " + e.message
          throw e

      else
        throw new errors.AttributeError(attribute)

  remove: (attribute) ->
    delete @mapping[attribute]

  addValidation: (callback) ->
    throw new Error('Validation is not a function') unless _.isFunction(callback)
    if callback.length == 0 || callback.length > 2
      throw new Error('Validation has wrong number of arguments')
    @validations.push(callback)

module.exports = Schema

s = new Schema
  firstName: 'String'
  lastName:  'String'
  single:    'Boolean'
  age:       'Number'
  preferences:
    receiveNewsletter: 'Boolean'
    makeProfilePublic: 'Boolean'

asyncValidation = (options) ->
  return (model, done) ->
    setTimeout ->
      console.log 'Async validation done!'
      done()

syncValidation = (options) ->
  return (model) ->
    return

s.addValidation(asyncValidation('doodah'))
s.addValidation(syncValidation('day'))

console.log s