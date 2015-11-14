#!/usr/bin/env node

'use strict';

// Usage:
// https://nodejs.org/api/process.html#process_process_argv
// $ node index.js one two=three four

/*
Output:
0: C:\Program Files\nodejs\node.exe ░▒▓█▓▒░ 2015.11.5. 12:2:43:415
1: c:\www\node\command-line-arguments\index.js ░▒▓█▓▒░ 2015.11.5. 12:2:43:415
2: one ░▒▓█▓▒░ 2015.11.5. 12:2:43:415
3: two=three ░▒▓█▓▒░ 2015.11.5. 12:2:43:415
4: four ░▒▓█▓▒░ 2015.11.5. 12:2:43:415
*/

// SEPARATORS: ░▒▓█▓▒░

// http://stackoverflow.com/questions/23023650/is-it-possible-to-pass-a-flag-to-gulp-to-have-it-run-tasks-in-different-ways
// http://justindavis.co/2014/11/24/using-command-line-arguments-in-a-node-script/
// https://www.npmjs.com/package/yargs

var timeStamp = function() {
  var d = new Date();
  var year = d.getFullYear();
  var month = d.getMonth() + 1;
  var day = d.getDay();
  var hours = d.getHours();
  var minutes = d.getMinutes();
  var seconds = d.getSeconds();
  var milliseconds = d.getMilliseconds();
  //var time = year + '.' + month + '.' + day + '. ' + hours + ':' + minutes + ':' + seconds + ':' + milliseconds;
  var time = year + '.' + month + '.' + day + '. ' + hours + ':' + minutes + ':' + seconds;
  return time;
};

var args = process.argv.slice(2);

if (args.length <= 0) {
  console.log("NO INPUT WAS DETECTED!\nFor get more help about the usage:\nUse the executible with \"-h\" or \"--help\" flags");
  process.exit(-1);
}

var domainExtensions = ['.com', '.cm', '.biz']; // better to be const

// print process.argv
args.forEach(function(val, index, array) {
  domainExtensions.forEach(function(tld) {
    //console.log(index + ' █ ' + val + '' + tld + ' █ ' + timeStamp());
    console.log(val + '' + tld + ' █ ' + timeStamp());
  });
});

/*if(args == '-f'){
  console.log('Fahrenheit');
} else {
  console.log('Celsius');
}*/
