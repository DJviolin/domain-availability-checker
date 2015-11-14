#!/usr/bin/env node

'use strict';

// Usage:
// https://nodejs.org/api/process.html#process_process_argv
// $ node index.js arg1 arg2

// http://stackoverflow.com/questions/23023650/is-it-possible-to-pass-a-flag-to-gulp-to-have-it-run-tasks-in-different-ways
// http://justindavis.co/2014/11/24/using-command-line-arguments-in-a-node-script/
// https://www.npmjs.com/package/yargs

var flagVersion = function() {
  return 'v1.0.0';
}

var flagHelp = function() {
  var upperSep = '△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△\n';
  var bottomSep = '\n▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽';
  var appname = 'Domain Checker'
  var contact = 'Istvan Lantos <info@LantosIstvan.com>'
  var helptext = 'This file\'s location:\n' + ' ' + process.argv[1] + '\n\n' + 'USAGE:\n $ node --harmony [APPNAME] [FLAGS] [ARGUMENTS]\n\n' + 'FLAGS:' + '\n -h, --help\t\tThis guide' + '\n -v, --version\t\t' + 'Print program version' + '\n -t, --tld\t\tDomain TLDs [.com .cm .biz .net]' + '\n\n' + 'ARGUMENTS:' + '\n For example: [DomainName1 DomainName2 ...]';

  return '\n' + upperSep + appname + '\n' + flagVersion() + '\nby ' + contact + '\n\n' + helptext + bottomSep;
};

var timeStamp = function() {
  var d = new Date();
  var year = d.getFullYear();
  var month = d.getMonth() + 1;
  var day = d.getDay();
  var hours = d.getHours();
  var minutes = d.getMinutes();
  var seconds = d.getSeconds();
  var milliseconds = d.getMilliseconds();
  var time = year + '.' + month + '.' + day + '. ' + hours + ':' + minutes + ':' + seconds;
  return time;
};

var args = process.argv.slice(2);

if (!~process.execArgv.indexOf('--harmony')) {
  console.log('ERROR!\nES6 is required, Node.js must be run with \"--harmony\" flag!\nExample: $ node --harmony [APPNAME] [FLAGS] [ARGUMENTS]');
  process.exit(-1);
}

if (args <= 0) {
  console.log("NO INPUT WAS DETECTED!\nFor get more help about the usage:\nUse the executible with \"-h\" or \"--help\" flags\nVersion info: \"-v\" or \"--version\"");
  process.exit(-1);
}

if((args == '-h' && args.length <= 1) || args == '--help'){
  console.log(flagHelp());
  process.exit(-1);
}

if(args == '-v' || args == '--version'){
  console.log(flagVersion());
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
