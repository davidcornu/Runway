var path = require('path');
var exec = require('child_process').exec;

desc('Build & watch CoffeeScript files');
task('build', [], function(){
  var srcDir = path.join(__dirname, 'src');
  var outDir = path.join(__dirname, 'lib');
  var coffee = path.join(__dirname, 'node_modules/coffee-script/bin/coffee')
  var cmd    = [coffee, '-o', outDir, '-cw', srcDir].join(' ');

  var child = exec(cmd, function(){ complete(); });
  child.stdout.pipe(process.stdout);
}, true);