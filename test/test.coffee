assert = require('assert')

TestModel = require('./test_model')

describe 'Runway', ->
  describe 'validations', ->
    it 'should validate presence', (done) ->
      t = new TestModel(firstName: 'Bob', email: 'bob@marley.com')
      t.validate (model) ->
        console.log(model.errors)
        assert(model.errors.length > 0)
        done()