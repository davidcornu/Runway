_           = require('lodash')
types       = require('./types')

validTypes = _.map(_.keys(types), (t) -> t.replace(/Runway/, ''))

class Schema

  constructor: (structure = {}) ->
    @mapping = {}
    @validations = []
    @add(structure)

  add: (structure) ->
    for attribute, type of structure
      if type in validTypes
        @mapping[attribute] = types['Runway' + type]
      else if _.isObject(type)
        @mapping[attribute] = new Schema(type)
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