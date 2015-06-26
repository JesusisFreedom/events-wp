module.exports = function(grunt) {
  var pjson = require('./package.json');
  var distname = pjson.version;

  grunt.initConfig({
    browserify: {
      build: {
        files: {
          'build/client.js': ['coffee/client.coffee']
        },
        options: {
          transform: ['coffeeify', 'hbsfy']
        }
      }
    },
    watch: {
      files: ["coffee/**/*"],
      tasks: ['browserify:build']
    },
    bump: {
      options: {
        files: ['package.json', 'composer.json'],
        commit: true,
        commitMessage: 'Release v'+distname,
        createTag: true,
        pushTo: 'origin',
        push: true
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-bump');
  grunt.registerTask('build', ['browserify:build']);
};