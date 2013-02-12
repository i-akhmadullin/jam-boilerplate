module.exports = (grunt) ->
  'use strict'

  @initConfig

    watch:
      scripts:
        files: '<config:lint.files>'
        tasks: 'concat reload'

      css:
        files: [
          'blocks/**/*.css',
          'blocks/**/*.styl',
          'blocks/**/*.less'
        ]
        tasks: 'styletto:dev styletto:dev_ie reload'

      reload:
        files: [
          '*.html'
        ]
        tasks: 'reload'

      jade:
        files: [
          'pages/**/*.jade'
        ]
        tasks: 'jade reload'

    jade:
      debug:
        options:
          pretty: true

        files:
          'about.html': 'pages/about.jade'
          'main.html':  'pages/main.jade'

    styletto:
      dev:
        src: [
          'blocks/i-reset/i-reset.styl',
          'lib/**/*.css',
          'blocks/b-*/**/*.css',
          'blocks/b-*/**/*.styl',
          'blocks/b-*/**/*.less'
        ]
        dest: 'publish/style.css'
        errors: 'alert'
        stylus:
          imports: [
            'blocks/config.styl',
            'blocks/i-mixins/i-mixins__clearfix.styl',
            'blocks/i-mixins/i-mixins__vendor.styl',
            'blocks/i-mixins/i-mixins__gradients.styl',
            'blocks/i-mixins/i-mixins__if-ie.styl'
          ]

      dev_ie:
        src: [
          'blocks/i-reset/i-reset.styl',
          'lib/**/*.css',
          'blocks/b-*/**/*.ie.css',
          'blocks/b-*/**/*.ie.styl',
          'blocks/b-*/**/*.ie.less'
        ]
        dest: 'publish/style.ie.css'
        errors: 'alert'
        stylus:
          variables: { 'ie': true }
          imports: [
            'blocks/config.styl',
            'blocks/i-mixins/i-mixins__clearfix.styl',
            'blocks/i-mixins/i-mixins__if-ie.styl'
          ]

      publish:
        src: '<config:styletto.dev.dest>'
        dest: '<config:styletto.dev.dest>'
        compress: true
        base64: true
        errors: 'error'

      publish_ie:
        src: '<config:styletto.dev_ie.dest>'
        dest: '<config:styletto.dev_ie.dest>'
        compress: true
        base64: true
        errors: 'error'


    concat:
      dist:
        src: [
          'lib/consoleshiv.js',
          'lib/**/!(jquery.min|html5shiv|consoleshiv).js',
          'blocks/**/*.js'
        ]
        dest: 'publish/script.js'

    min:
      dist:
        src: '<config:concat.dist.dest>'
        dest: '<config:concat.dist.dest>'

    lint:
      files: [
        'Gruntfile.js',
        'lib/**/*.js',
        'blocks/**/*.js'
      ]

    server:
      # uncommment to set custom port
      # port: 3502,
      base: process.cwd()


  @registerTask 'default', 'concat styletto:dev styletto:dev_ie jade'
  @registerTask 'reloader', 'concat styletto:dev styletto:dev_ie jade server'
  @registerTask 'publish', 'concat min styletto jade'
