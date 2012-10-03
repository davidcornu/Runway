_      = require('lodash')
types  = require('./types')
errors = require('./errors')

# s = new Schema
#   firstName: 'String'
#   lastName:  'String'
#   registered: 'Boolean'
#   favourites: 'Array'

validTypes = _.keys(types)

class Schema

  constructor: (structure = {}) ->
    @mapping = {}
    @add(structure)

  add: (structure) ->
    for attribute, type of structure
      if type in validTypes
        @mapping[attribute] = types[type]
      else
        throw new errors.AttributeError(attribute)

  remove: (attribute) ->
    delete @mapping[attribute]

module.exports = Schema