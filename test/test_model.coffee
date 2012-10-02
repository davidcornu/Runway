path      = require('path')

basePath  = path.resolve(__dirname, '../')
Runway    = require(path.join(basePath, 'lib/runway'))
validates = require(path.join(basePath, 'lib/validators'))

class TestModel extends Runway

  attributes: Object.freeze(['firstName', 'lastName', 'email'])

  initialize: ->
    # @addValidator(validates.presenceOf('firstName'))
    @addValidator(validates.presenceOf('lastName'))
    # @addValidator(validates.presenceOf('email'))
    # @addValidator(validates.formatOf('email', /[\w@\._-]+/))

module.exports = TestModel