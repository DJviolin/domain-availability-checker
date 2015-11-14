#!/usr/bin/env node

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

var timeStamp = function() {
  var d = new Date();
  var year = d.getFullYear();
  var month = d.getMonth() + 1;
  var day = d.getDay();
  var hours = d.getHours();
  var minutes = d.getMinutes();
  var seconds = d.getSeconds();
  var milliseconds = d.getMilliseconds();
  var time = year + '.' + month + '.' + day + '. ' + hours + ':' + minutes + ':' + seconds + ':' + milliseconds;
  return time;
};

//better to be const
var domainExtensions = ['.com', '.biz'];

// print process.argv
process.argv.slice(2).forEach(function(val, index, array) {
  domainExtensions.forEach(function(tld) {
     console.log(index + ': ' + val + '' + tld + ' █ ' + timeStamp());
  });
});
