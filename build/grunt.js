/*global module:false*/
module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    watch: {
      scripts: {
        files: '<config:lint.files>',
        tasks: 'concat'
      },
      css: {
        files: ['../blocks/*.css', '../blocks/*.styl', '../blocks/**/*.css', '../blocks/**/*.styl', '../blocks/**/*.less'],
        tasks: 'styletto:dev styletto:dev_ie'
      }
    },
    styletto: {
      dev: {
        src: ['../blocks/_b-reset/b-reset.styl', '../lib/**/*.css', '../blocks/**/!(!*|*.ie).css', '../blocks/**/!(!*|*.ie).styl'],
        dest: '../publish/style.css'
      },
      dev_ie: {
        src: ['../blocks/_b-reset/b-reset.ie.styl', '../blocks/**/!(!*)*.ie.styl', '../blocks/**/!(!*)*.ie.css'],
        dest: '../publish/style.ie.css'
      },
      publish: {
        src: '<config:styletto.dev.src>',
        dest: '../publish/style.min.css',
        compress: true,
        base64: true
      },
      publish_ie: {
        src: '<config:styletto.dev_ie.src>',
        dest: '../publish/style.ie.min.css',
        compress: true,
        base64: true
      }
    },
    meta: {
      version: '0.1.0',
      banner: '/*! JAM-BOILERPLATE - v<%= meta.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        '* http://PROJECT_WEBSITE/\n' +
        '* Copyright (c) <%= grunt.template.today("yyyy") %> ' +
        'YOUR_NAME; Licensed MIT */'
    },
    lint: {
      files: ['grunt.js', '../lib/**/*.js', '../blocks/**/*.js']
    },
    concat: {
      dist: {
        src: ['../lib/**/*.js', '../blocks/**/*.js'],
        dest: '../publish/script.js'
      }
    },
    min: {
      dist: {
        src: '<config:concat.dist.dest>',
        dest: '../publish/script.min.js'
      }
    },
    csslint: {
      blocks: {
        src: '../blocks/**/*.css',
        rules: {
          "import": false,
          "overqualified-elements": 2
        }
      }
    },
    jshint: {
      options: {
        curly: true,
        eqeqeq: true,
        immed: true,
        latedef: true,
        newcap: true,
        noarg: true,
        sub: true,
        undef: true,
        boss: true,
        eqnull: true,
        browser: true
      },
      globals: {
        jQuery: true
      }
    },
    uglify: {}
  });

  grunt.loadNpmTasks('grunt-styletto');
  grunt.loadNpmTasks('grunt-css');

  grunt.registerTask('default', 'concat styletto:dev styletto:dev_ie');
  grunt.registerTask('watcher', 'concat styletto:dev styletto:dev_ie watch');
  grunt.registerTask('publish', 'concat lint styletto csslint min');

};
