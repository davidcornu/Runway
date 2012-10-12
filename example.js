var Runway      = require('./lib/runway');
var coerce      = require('./lib/filters/coerce');
var validations = require('./lib/filters/validations');

var userPreferencesValidator = (new Runway())
  .attribute('receiveNewsletter', false)
  .attribute('keepFavorites', true)
  .use('receiveNewsletter', validations.isPresent)
  .use('keepFavorites',     validations.isPresent)
  .use('receiveNewsletter', coerce.boolean)
  .use('keepFavorites',     coerce.boolean);


var userValidator = (new Runway())
  .attribute('firstName')
  .attribute('lastName')
  .attribute('email')
  .attribute('age')
  .attribute('active', false)
  .attribute('preferences')

  .use('firstName',   coerce.string)
  .use('lastName',    coerce.string)
  .use('email',       coerce.string)
  .use('age',         coerce.number)
  .use('active',      coerce.boolean)
  .use('preferences', coerce.object)
  .use('preferences', function(value, callback){ userPreferencesValidator.run(value, callback); })

  .use('all', function(value, done){
    setTimeout(function(){
      try {
        var result = validations.isPresent(value);
        done(null, result);
      } catch(e) {
        if (e.name == 'TypeError') throw(e);
        done(e);
      }
    }, 0);
  });

var user = {
  firstName: 'David',
  email: 'davidjcornu@gmail.com',
  age: '18',
  preferences: {
    receiveNewsletter: true,
    keepFavorites: 'doodah'
  }
}

userValidator.run(user, function(errors, result) {
  console.log(errors, result);
});
